From: Gregor =?iso-8859-1?q?M=FCckl?= <GregorMueckl@gmx.de>
Subject: Newbie: Broken pipe on snd_pcm_start
Date: Sat, 20 Nov 2004 18:33:52 +0100
Message-ID: <200411201833.52248.GregorMueckl@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AA4nBjYdcz1Gbc3"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_AA4nBjYdcz1Gbc3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

In order to familiarize myself with ALSA, I've tried to write a simple program 
which attaches to the sound card and outputs a sound buffer read from a file. 
However, I've got a couple of problems with it: Although snd_pcm_prepare() is 
not reporting any errors, the sound won't play if I write it out using 
snd_pcm_writei(). I tried to use snd_pcm_start() but this fails immediately 
with a broken pipe error message. Should this actually tell me that a buffer 
underrun happened?

I've attached my test program (yes, quite a hack, I know) and don't know why 
it isn't working. Can you tell me what I do wrong? Thanks.

Gregor

--Boundary-00=_AA4nBjYdcz1Gbc3
Content-Type: text/x-c++src;
  charset="us-ascii";
  name="wavplay.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wavplay.cc"

#include <iostream>

#include <alsa/asoundlib.h>

class Error {
 public:
  Error(std::string message, std::string location)
  {
    this->message=message;
    this->location=location;
  };

  std::string getMessage() { return message; };
  std::string getLocation() { return location; };

 protected:
  std::string message, location;
};

class Buffer {
 public:
  Buffer();
  ~Buffer();

  void loadFromFile(std::string filename);

  void resetPointer();
  int read(int numSamples, unsigned char *buffer);

 protected:
  int length;
  int currentPosition;
  unsigned char *data;
};

Buffer::Buffer()
{
  length=0;
  currentPosition=0;
  data=0;
}

void Buffer::loadFromFile(std::string filename)
{
  FILE *input;

  input=fopen(filename.c_str(),"rb");
  if(!input) {
    throw Error("unable to open input file " + filename,"Buffer::loadFromFile");
  }

  fseek(input,0,SEEK_END);

  length=ftell(input);

  if(data)
    delete data;
  data=new unsigned char[length];

  fread(data,1,length,input);

  fclose(input);
}

void Buffer::resetPointer()
{
  currentPosition=0;
}

int Buffer::read(int numSamples, unsigned char *buffer)
{
  int newPosition;
  int difference;

  newPosition=currentPosition+numSamples;
  if(newPosition>length)
    newPosition=length;

  difference=newPosition-currentPosition;

  memcpy(buffer,data+currentPosition,difference);

  currentPosition=newPosition;

  std::cout << "currentPosition=" << currentPosition << std::endl;

  return difference;
}

void checkedAlsaCall(int result, std::string message)
{
  if(result<0) {
    throw Error(message + "; ALSA says: " + std::string(snd_strerror(result)),"checkedAlsaCall");
  }
}

int main(int argc, char *argv[])
{
  snd_pcm_t *playbackHandle;
  snd_pcm_hw_params_t *hwParams;
  unsigned int rate;
  short buffer[10240];
  int error;

  Buffer *file;
  int fetched;
  
  try {
    // init device:
    checkedAlsaCall(snd_pcm_open(&playbackHandle,argv[1],SND_PCM_STREAM_PLAYBACK,0),"unable top open sound device " + std::string(argv[1]));
    checkedAlsaCall(snd_pcm_hw_params_malloc(&hwParams),"unable to allocate hardware parameters");
    checkedAlsaCall(snd_pcm_hw_params_any(playbackHandle,hwParams),"unable to obtain hardware parameters from playback handle");
    checkedAlsaCall(snd_pcm_hw_params_set_access(playbackHandle,hwParams,SND_PCM_ACCESS_RW_INTERLEAVED),"unable to set access mode");
    checkedAlsaCall(snd_pcm_hw_params_set_format(playbackHandle,hwParams,SND_PCM_FORMAT_S16_LE),"unable to set sound buffer format");
    rate=44100;
    checkedAlsaCall(snd_pcm_hw_params_set_rate_near(playbackHandle,hwParams,&rate,0),"unable to set sample rate");
    checkedAlsaCall(snd_pcm_hw_params_set_channels(playbackHandle,hwParams,2),"unable to set number of channels");
    checkedAlsaCall(snd_pcm_hw_params(playbackHandle,hwParams),"unable to apply set parameters to hardware");
    snd_pcm_hw_params_free(hwParams); // this cannot fail

    // open device and output audio:
    checkedAlsaCall(snd_pcm_prepare(playbackHandle),"unable to prepare hardware for output");

    file=new Buffer;
    file->loadFromFile(argv[2]);

    checkedAlsaCall(snd_pcm_start(playbackHandle),"unable to start stream");

    while((fetched=file->read(2048,(unsigned char*)buffer))!=0) {
      std::cout << "fetched " << fetched << " bytes from buffer" << std::endl;
      if((error=snd_pcm_writei(playbackHandle,buffer,fetched/2))!=fetched/2) {
	throw Error("unable to write data to output device; ALSA says " + std::string(snd_strerror(error)),"main()");
      }
      while(!snd_pcm_wait(playbackHandle,10));
    }

    snd_pcm_close(playbackHandle); // this cannot fail
  } catch (Error e) {
    std::cerr << "Error: " << e.getMessage() << std::endl;
    std::cerr << "In: " << e.getLocation() << std::endl;
  }
}

--Boundary-00=_AA4nBjYdcz1Gbc3--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
