From: "Cyril.Coquilleau@UTBM.fr" <Cyril.Coquilleau@utbm.fr>
Subject: Re: capture with non-interleaved mode
Date: Sun, 19 Oct 2003 21:46:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066592802.3f92ea2267a80@webmail.utbm.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi !

I managed to capture sound but I have a problem due to the stereo. It is
impossible to capture data of channels separately.

I made a test for that : I have generated a sound with a square frequency of
2000 Hz in the left channel and a square frequency of 6000 Hz in the right
channel. And when I capture this sound I only have the sound of the right
channel : in the buffer I have the data of the right channel, but the data of
the left channel is replaced the right one.
I think that the stereo is taken only from the right channel (the signal is
exactly the same at the same time).

I join you the source of my program, if see the error...



#define BUF_SIZE 4096
#define ECHANT 44100
#define LASTING 10000

struct snd_card
{
  snd_pcm_t *handle;
  snd_pcm_hw_params_t *params;

  char *name;
  char *card_id;  

  short inputBuffer[BUF_SIZE*2];  
  void *buffer[2];
};

typedef struct snd_card snd_card_t;


/////////////////////////////////
// Assigns a card to the program
snd_card_t*
assign_card (int card)
{
  char card_id[32];
  int err;
  snd_card_t *returned_card;
  returned_card = calloc(1,sizeof(snd_card_t));

  // Initialize the buffer
  returned_card->buffer[0] = returned_card->inputBuffer;
  returned_card->buffer[1] = &returned_card->inputBuffer[BUF_SIZE];
  
  snprintf (card_id, 32, "plughw:%d", card);
  returned_card->card_id = strdup(card_id);

  // I removed the error handlers
  snd_pcm_open (&returned_card->handle, returned_card->card_id,
SND_PCM_STREAM_CAPTURE, 0);
  snd_pcm_hw_params_malloc (&returned_card->params);
  snd_pcm_hw_params_any (returned_card->handle, returned_card->params);
  //2 for the two channels for stereo
  snd_pcm_hw_params_set_channels (returned_card->handle, returned_card->params, 2);
  snd_pcm_hw_params_set_access (returned_card->handle, returned_card->params,
SND_PCM_ACCESS_RW_NONINTERLEAVED);
  snd_pcm_hw_params_set_format (returned_card->handle, returned_card->params,
SND_PCM_FORMAT_S16_LE);
  snd_pcm_hw_params_set_rate_near (returned_card->handle, returned_card->params,
ECHANT, 0);
  snd_pcm_hw_params (returned_card->handle, returned_card->params);
  snd_pcm_hw_params_free (returned_card->params);
  snd_pcm_prepare (returned_card->handle);
  return returned_card;
}


///////////////////////////////////////////////////// 
// Main 
int 
main (int argc, char *argv[]) 
{
  int i=0;
  int err;
  int card_number = 0;
  snd_card_t *card1;
 
  card1 = assign_card(card_number);

  for (i=0; i<LASTING; i++) 
  {
    err = snd_pcm_readn (card1->handle, card1->buffer, BUF_SIZE);
     
    if (err >= BUF_SIZE) 
    {
      // Write the content of the buffer into a file to examine the content
    } // End of treatment of the two channels
    else if (err == -EPIPE) 
    {     
      printf("Under-Run \n");
      // under-run 
      snd_pcm_prepare (card1->handle);
    } 
    else if (err == -ESTRPIPE) 
    {
      
      while ((err = snd_pcm_resume (card1->handle)) == -EAGAIN)
        sleep(1);       // wait until the suspend flag is released
	
      if (err < 0) 
        snd_pcm_prepare (card1->handle);  // prepare again to read
    }
  }
  
  snd_pcm_close (card1->handle);
  return 0;
}



And here is a very small part of the text file obtained, we see the data of left
channel is always the same as the right (altough the frequencies of each channel
are differents).

LEFT CHANNEL  ----   RIGHT CHANNEL
    
buff=25531    ----    25448
buff=29062    ----    29024
buff=28990    ----    28953
buff=25640    ----    25564
buff=27761    ----    27714
buff=-31412    ----    -31364
buff=-29466    ----    -29392
buff=-32110    ----    -32067
buff=-32600    ----    -32571
buff=30326    ----    30317
buff=28573    ----    28537
buff=30212    ----    30202
buff=31043    ----    31031
buff=28114    ----    28063
buff=32445    ----    32458



Cyril Coquilleau


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
