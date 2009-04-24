From: "Sudeept Prusti" <sudeeptp@tataelxsi.co.in>
Subject: Help
Date: Fri, 24 Apr 2009 17:01:57 +0530
Message-ID: <9D5E1752379A43408015F7FE98466115023F03C3@CHNEXVS01.VSNLXCHANGE.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpin1.mailsecure.in (SMTPIN1.mailsecure.in [121.241.224.1])
	by alsa0.perex.cz (Postfix) with ESMTP id BC1FC103898
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 13:33:56 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,
 
As i am working on alsa for minimal PCM playback (8khz,mono,16 bit pcm file).
 
When i tried to allocate 1k buffer and send through snd_pcm_writei() call it doesn't play perfect and skips are there in between. If we keep on increasing in allocating the buffer for 31 kb then it could play the buffers randomly.
 
Code is attached for ur reference below.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>

#define  k	(31*1024)

static void playback(FILE *fd);

int main(int argc, char *argv[]) 
{
  FILE *fd;
  fd = fopen(argv[1],"r");
  playback(fd);
  return 0;
}

static void playback(FILE *fd)
{
  int rc,err;
  snd_pcm_t *handle;
  snd_pcm_hw_params_t *params;
  unsigned int val;
  snd_pcm_uframes_t frames;
  unsigned char *buffer;
  int seek_size=0;
  int nonblock = 0;

  printf("Entered Playback Module \n");
	
  /* Open PCM device for playback. */
  rc = snd_pcm_open(&handle, "default",SND_PCM_STREAM_PLAYBACK, 0);
  if(rc >= 0)
  {
  	printf("Open PCM Success:  %d \n",rc);
  }
  if (rc < 0) {
    	fprintf(stderr,"unable to open pcm device: %s\n",snd_strerror(rc));
	exit(1);
  }
  
  /* PCM Hardware Parameters Allocation.  */
  err = snd_pcm_hw_params_malloc (&params);

  if(err>=0)
  {
	printf("Hardware Params Allocation Success:  %d \n",err);
  }

  if (err < 0)
  {
  	fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n", snd_strerror (err));
      	exit (1);
  }
  /* Intialize PCM Hardware Parameters */	
  err = snd_pcm_hw_params_any(handle, params);
  if(err >=0)
  {
  	printf("PCM HW params Initialization Success : %d \n",err);
  }
  if (err < 0)
  {
	printf("Cannot initialize hardware parameter structure \n");
	exit(EXIT_FAILURE);
  }

  /* Set the PCM Hardware parameters. */

  /* Interleaved mode */
  err = snd_pcm_hw_params_set_access(handle, params,SND_PCM_ACCESS_RW_INTERLEAVED);
  if (err >= 0)
  {
	printf("Access Type Available: %d \n",err);
  }
  if (err < 0)
  {
	printf("Access Type Not-available: %d \n",err);
	exit(EXIT_FAILURE);
   }

  /* Signed 16-bit little-endian format */
  err = snd_pcm_hw_params_set_format(handle, params,SND_PCM_FORMAT_S16_LE);
  if (err >= 0)
  {
	printf("Sample format Available: %d \n",err);
  }
  if (err < 0)
  {
	printf("Sample format Non-Available \n");
	exit(EXIT_FAILURE);
  }

  /* One Channel (Mono) */
  err = snd_pcm_hw_params_set_channels(handle, params, 1);
  if (err >= 0)
  {
	printf("Channels Available: %d \n",err);
  }
  if (err < 0)
  {
	printf("Channels Non-Available \n");
	exit(EXIT_FAILURE);
  }

  /* 8khz sampling rate */
  err = snd_pcm_hw_params_set_rate (handle, params, 8000, 0);
  if (err >= 0)
  {
      	printf ("Sample Rate Set Success: %d \n",err);
  }
  if (err < 0)
  {
      	fprintf (stderr, "cannot set sample rate (%s)\n", snd_strerror (err));
      	exit (EXIT_FAILURE);
  }
  
  /* Write the parameters to the alsa-driver */
  rc = snd_pcm_hw_params(handle, params);
  if(rc >=0)
  {
  	printf("Set HW Parameters Success: %d \n",rc);
  }
  if (rc < 0)
  {
   	fprintf(stderr,"Unable to Set HW Parameters: %s\n",snd_strerror(rc));
	exit(1);
  }
  /* Allocate buffer*/
  buffer = (unsigned char *) malloc(k);

  if (buffer == NULL)
  {
	printf("Not Enough Memory: %c \n",buffer);
	exit(1);
  }

  while (!feof(fd))
  {
    if(fd != NULL)
    {
 	printf("File pointer is not NULL \n");
    }
    printf("Current Position of File Pointer is: %d\n",ftell(fd));

    rc = fread(buffer,k,1,fd);
    printf("Data Read from File is: %d \n",rc);
    
    if(rc > 0)
    {
    	printf("File Read Success \n");
    }
    
    seek_size = seek_size + k;    
    fseek(fd,seek_size,SEEK_SET);

    if (rc == 0)
    {
      	printf("End of File Reached: %d \n",rc);
      	break;
    } 
    rc = snd_pcm_writei(handle, buffer, k);
    printf("Write: %d  bytes \n",rc);
    
    if (rc == -EPIPE)
    {
      printf("underrun occurred \n");
      snd_pcm_prepare(handle);
    }
    else if (rc < 0)
    {
    	fprintf(stderr,"Error From Writei Call: %s\n",snd_strerror(rc));
       exit(1);
    }  
   }//End of While
   
   fclose(fd);
   snd_pcm_drain(handle);
   snd_pcm_close(handle);
   free(buffer);
}//End of Playback
--------------------------------------------------------------------------------------------------------------
Can anyone help me out where i am doing wrong.Ur's valuable suggestions are welcomed.
 
Best Regards,
Sudeept
