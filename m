From: User for realtime audio <audiodev@ind.RWTH-Aachen.DE>
Subject: Re: Application using ALSA-driver es-1968 for Maestro-2e:
 Bug or my fault?
Date: Mon, 17 Jun 2002 15:08:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D0DDF5B.8384EA17@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi again,
I have added some more information for my previous message:

The write_loop function is the modified version from the pcm-example:
(Buffer "samples_input"  has been allocated using:

 samples_input = (signed short*)malloc(buffersize*amountChannels_input *
snd_pcm_format_width(handle));

with buffersize = 64, amountChannels_input = 2,
snd_pcm_format_width(handle)=16;)


// SOURCECODE: Function write_loop

#define DATATYPE short int
#define DUMP_DATA

int
realTimeIO::write_loop()
{
    int err;
    int avail_in;
    int chans;
    void** bufs_input =
(void**)malloc(sizeof(void*)*amountChannels_input);
    void** bufs_output =
(void**)malloc(sizeof(void*)*amountChannels_output);

#ifdef DUMP_DATA
    // Set data to 1 for buffersize=64 to check whether readn copies
data to buffer (quick hack for testing)
    for(int i=0; i < 128; i++)
 samples_input[i] = -10000;
#endif

    for(int i = 0; i < amountChannels_input; i++)
    {
 bufs_input[i] = (((DATATYPE*)samples_input)) + (buffersize*i);
    }
    for(int i = 0; i < amountChannels_output; i++)
 bufs_output[i] = (((DATATYPE*)samples_output)) + (buffersize*i);

    while (1)
    {
 avail_in = snd_pcm_avail_update(pcmHandle_input);
 if(avail_in >= buffersize)
 {
     if(accessModeInput == SND_PCM_ACCESS_RW_INTERLEAVED)
     {
  err = snd_pcm_readi(pcmHandle_input, samples_input, buffersize);
     }
     else
     {
#ifdef DUMP_DATA
  cnt ++;
  if(cnt > 100)
      cout << "Buffersize: Reading " << buffersize << " elements!" <<
endl;
#endif
  err = snd_pcm_readn(pcmHandle_input, bufs_input, buffersize);
     }

#ifdef DUMP_DATA

     if(cnt > 100)
     {
  cout << "DATA DUMP FOR DEBUGGING:" << endl;
  cout << "Buffersize:" << buffersize << endl;
  cout << "Amount channels input:" << amountChannels_input << endl;
  cout << "Samples available:" << avail_in << endl;

  // Dump data for buffersize=64 (quick hack for testing)
  for(int i = 0; i < amountChannels_input * 64; i++)
      cout << "Val[" << i << "]=" << samples_input[i] << endl;
  exit(0);
     }
#endif

 }
 if(accessModeOutput == SND_PCM_ACCESS_RW_INTERLEAVED)
 {
     err = snd_pcm_writei(pcmHandle_output, samples_input, buffersize);
 }
 else
 {
     err = snd_pcm_writen(pcmHandle_output, bufs_input, buffersize);
 }
 if (err < 0)
 {
     if (xrun_recovery(pcmHandle_input, err) < 0)
     {
  printf("Write error: %s\n", snd_strerror(err));
  exit(EXIT_FAILURE);
     }
 }
    }
}

// END FUNCTION write_loop



Of course I get non interleaved and interleaved modes mixed up but
the problem is only about the capture anyway!

The output from the execution of the application is the following:




==================================
Success in opening devices!
Success in determining PCM devices!
Device for input is:ESS Maestro
Subdevice for input is:subdevice #0
Stream: Direction:1
Device for output is:ESS Maestro
Subdevice for input is:subdevice #0
Stream: Direction:0
==================================================
Hardware parameters have been prepared!
For input device:
Formats:
Supported:SND_PCM_FORMAT_S16
Access types:
Supported:MMAP_NONINTERLEAVED
Supported:RW_NONINTERLEAVED
Channels: ==============================
Min:1
Max:2
Sampling rate: ==============================
Min:4000
Max:48000
For output device:
Formats:
Supported:SND_PCM_FORMAT_U8
Supported:SND_PCM_FORMAT_S16
Access types:
Supported:MMAP_INTERLEAVED
Supported:RW_INTERLEAVED
Channels: ==============================
Min:1
Max:2
Sampling rate: ==============================
Min:4000
Max:48000
Buffersize:64
Bufferlength:128
Modified Buffersize:64
Setting up 2 channels for input.!
Setting up 2 channels for output.!
Bits input:16
Bits output:16
Output and input have been linked together!
Playback device is hw:0,0
Stream parameters are 16000Hz, S16_LE, 2 amountChannels_output
!!!Scheduler set to Round Robin with priority FAILED!!!99
Buffersize: Reading 64 elements!
DATA DUMP FOR DEBUGGING:
Buffersize:64
Amount channels input:2
Samples available:68
Val[0]=-4
Val[1]=-1
Val[2]=0
Val[3]=-4
Val[4]=-5
Val[5]=0
Val[6]=0
Val[7]=0
Val[8]=-1
Val[9]=0
Val[10]=-1
Val[11]=-2
Val[12]=-2
Val[13]=-1
Val[14]=0
Val[15]=-1
Val[16]=-2
Val[17]=0
Val[18]=-5
Val[19]=-3
Val[20]=-1
Val[21]=0
Val[22]=0
Val[23]=-3
Val[24]=-1
Val[25]=-3
Val[26]=-3
Val[27]=0
Val[28]=0
Val[29]=1
Val[30]=2
Val[31]=0
Val[32]=-10000
Val[33]=-10000
Val[34]=-10000
Val[35]=-10000
Val[36]=-10000
Val[37]=-10000
Val[38]=-10000
Val[39]=-10000
Val[40]=-10000
Val[41]=-10000
Val[42]=-10000
Val[43]=-10000
Val[44]=-10000
Val[45]=-10000
Val[46]=-10000
Val[47]=-10000
Val[48]=-10000
Val[49]=-10000
Val[50]=-10000
Val[51]=-10000
Val[52]=-10000
Val[53]=-10000
Val[54]=-10000
Val[55]=-10000
Val[56]=-10000
Val[57]=-10000
Val[58]=-10000
Val[59]=-10000
Val[60]=-10000
Val[61]=-10000
Val[62]=-10000
Val[63]=-10000
Val[64]=-4
Val[65]=-1
Val[66]=0
Val[67]=-4
Val[68]=-5
Val[69]=0
Val[70]=0
Val[71]=0
Val[72]=-1
Val[73]=0
Val[74]=-1
Val[75]=-2
Val[76]=-2
Val[77]=-1
Val[78]=0
Val[79]=-1
Val[80]=-2
Val[81]=0
Val[82]=-5
Val[83]=-3
Val[84]=-1
Val[85]=0
Val[86]=0
Val[87]=-3
Val[88]=-1
Val[89]=-3
Val[90]=-3
Val[91]=0
Val[92]=0
Val[93]=1
Val[94]=2
Val[95]=0
Val[96]=-10000
Val[97]=-10000
Val[98]=-10000
Val[99]=-10000
Val[100]=-10000
Val[101]=-10000
Val[102]=-10000
Val[103]=-10000
Val[104]=-10000
Val[105]=-10000
Val[106]=-10000
Val[107]=-10000
Val[108]=-10000
Val[109]=-10000
Val[110]=-10000
Val[111]=-10000
Val[112]=-10000
Val[113]=-10000
Val[114]=-10000
Val[115]=-10000
Val[116]=-10000
Val[117]=-10000
Val[118]=-10000
Val[119]=-10000
Val[120]=-10000
Val[121]=-10000
Val[122]=-10000
Val[123]=-10000
Val[124]=-10000
Val[125]=-10000
Val[126]=-10000
Val[127]=-10000



The first lines are only for verbose mode, however at the end the data
dump files are printed.
Everything seems fine, there are 68 samples available and 64 are
requested to be read but also
it can be seen (therefore the initialization with -10000) that the
values from
32 to 63 and those from 96 to 127 are NOT set to new values by a copy
process.

I have run the application without data dump and printed all information
in
/proc/asound/card0/pcm0c/sub0/* while the application was running:

access: RW_NONINTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 16000 (16000/1)
period_size: 64
buffer_size: 128
tick_time: 10000
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ESS Maestro
name: ESS Maestro
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
state: RUNNING
trigger_time: 1024319237.293920
tstamp      : 1024319251.312477
delay       : 54
avail       : 54
avail_max   : 142
-----
hw_ptr      : 224310
appl_ptr    : 224256
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 64
xfer_align: 1
start_threshold: 128
stop_threshold: 128
silence_threshold: 0
silence_size: 0
boundary: 1073741824

I hope this gives a better impression about the used application.

I may send the complete sourcecode of my application to anyone who
intends to test it with his own device.

Again thanks for any help in advance!

Hauke






> FROM: User for realtime audio
> DATE: 06/17/2002 02:41:20
> SUBJECT:  [Alsa-devel] Application using ALSA-driver es-1968 for
Maestro-2e: Bug or my fault?

> Hi,

> I have a question to all those who have experience with a Maestro-2e
> soundcard and ALSA-applications:

> I have written a realtime-capture plus playback application for
realtime
> signal processing algorithms. It is simply
> a modification of the PCM-example.

> The software did work with my old notebook including an es-1668
> soundcard but with the new es-1968 device none of the possible
transfer
> modes function propperly.

> The problem is that only parts of the buffers seem to be read
correctly
> for capture, for example I have the IO-read access to a 16 bit capture

> device, periodsize is 64, buffersize 128 and two channels input.

> The card only support non interleaved input (although only interleaved

> output for playback!).

> Furthermore I have one buffer for sampleinput:

>  signed short inputBuffer[128];

> (2 channels, 64 samples for call of snd_pcm_readn(..))

> In order to use non interleaved read-function I have created the
> void**-field:

>  void** bufsInput[2];

> for each channel and assigned the sample-buffer to each channel:

>  bufsInput[0] = inputBuffer;
>  bufsInput[1] = &inputBuffer[64];


> In my callback-loop for audio read process I check that there are more

> than 64 samples available
> If so I call the read function:

>  err=snd_pcm_readn(pcmDevice_capture, bufsInput, 64);

> After this call err is equal 64 so everything is fine.
> When dumping the received data some strange values are stored:

> - sampleBuffer[0] .. sampleBuffer[15] seem to be the result from
>   channel1 which is still correct.
> - sampleBuffer[16]..sampleBuffer[31] seem to be the result from the
>   other channel which is not correct anymore
>   (I can distinguish the channels as I am using different signals on
the
>   two channels)
> - sampleBuffer[32].. sampleBuffer[63] have not been copied. The values

>   in sampleBuffer BEFORE the snd_pcm_readn-call still remain
unchanged!
> - From sampleBuffer[64] .. sampleBuffer[127] the values from
>   sampleBuffer[0] .. sampleBuffer[63] are repeated.

> I would expect that values from 0 to 63 contain channel1 input and
> values from 64 to 127 contain other channel input..

> Did I misunderstand the ALSA-API, what am I doing wrong or is there a
> bug in the ALSA-driver/library for this specific application?

> aplay and the pcm example do function as expected but arecord seems to

> generate some clicking noise either....


> System: I am using a Dell Lattitude CPH-500 notebook, SUSE linux,
kernel
> 2.4.16 with the lowlatency patches + rtc-patch found in the
> alsa-beta0.12 package. The current alsa-version however is the current

> release candidate (rc1). I have also tried to use the
> unpatched 2.4.18 kernel which did not lead to different results.

> I d appreceate any kind of hint or other experiences with this device,

> thanks in advance

> Hauke




_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
