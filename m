From: "K.Shyam" <shyamk@lycos.com>
Subject: reading/writing raw audio from soundcard
Date: Tue, 14 May 2002 16:42:35 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <HJCBLODJCGCKFAAA@mailcity.com>
Reply-To: shyamk@lycos.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Language: en
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

Hi;
I am trying to read and write raw audio from my soundcard which is an es1371.
the code i use is as follows :

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <linux/soundcard.h>
#include <signal.h>


int breakLoop = 0; /* for breaking from soundcard reading */

void catch_interrupt(int sig_num) 
{ 
    sigset_t mask_set; 
    sigset_t old_set; 

     /* for next interrupt */ 
    signal(SIGINT, catch_interrupt); 
    /* mask any further signals */ 
    sigfillset(&mask_set); 

    sigprocmask(SIG_SETMASK, &mask_set, &old_set); 
    breakLoop = 1;
    sigprocmask(SIG_SETMASK, &old_set, NULL); 
} 


int main()
{
	int fd = 0,bytesRead=0,format=0,retVal=0,frameSize = 0;
	unsigned int channel=1,samplingRate=8000;
	unsigned char *soundBuffer = NULL;
	FILE *fp = NULL;
    
	/* set the Ctrl-C  signal handler */ 
    signal(SIGINT, catch_interrupt); 
	if ( ( fd = open("/dev/dsp",O_RDONLY) ) < 0 )
	{
		printf("Unable to open sound device\n");
		printf("Error reason = %s\n",strerror(errno));
		return(0);
	}
	if ( ( fp = fopen("./audiobuf","wb") ) == NULL )
	{
		printf("Unable to open file\n");
		printf("Error reason = %s\n",strerror(errno));
		if ( ( retVal = close(fd) ) < 0 )
		{
			printf("Error on closing sound card's descriptor\n");
			printf("Error reason = %s\n",strerror(errno));
		}
		return(0);
	}
    format = AFMT_S16_LE;
	retVal =  ioctl(fd,SNDCTL_DSP_SETFMT,&format);
	if ( ( retVal < 0 ) || ( format != AFMT_S16_LE ) )
	{
		printf("Unable to set ioctl for audio format\n");
		if ( format == AFMT_S16_LE )
		{
			printf("Error reason = %s\n",strerror(errno));
			errno = 0;
		}
		else
		{
			printf("Wrong Format Argument\n");
		}
	}
	retVal = ioctl(fd,SNDCTL_DSP_CHANNELS,&channel);
	if ( ( retVal < 0 ) || ( channel != 1 ) )
	{
		printf("Unable to set ioctl for audio channel\n");
		if ( channel == 1 )
		{
			printf("Error reason = %s\n",strerror(errno));
			errno = 0;
		}
		else
		{
			printf("Wrong channel Argument\n");
		}
	}
	retVal = ioctl(fd,SNDCTL_DSP_SPEED,&samplingRate);
	if ( ( retVal < 0 ) || ( samplingRate != 8000 ) )
	{
		printf("Unable to set ioctl for sampleing rate\n");
		if ( samplingRate == 8000 )
		{
			printf("Error Reason = %s\n",strerror(errno));
		}
		else
		{
			printf("Wrong sampling rate argument\n");
		}
	}
	/* set the frame size to be 8000 * 1 * sizeof */
	/* important note : how do we know data is at 8k,8 bits/sec.where do we set it ?? */
	frameSize = samplingRate * channel * sizeof(unsigned char);
	printf("Frame size is %d\n",frameSize);
	errno = 0;
	if ( ( soundBuffer = (unsigned char *)malloc(frameSize) ) == NULL )
	{
		printf("Unable to allocate memory\n");
		printf("Error reason = %s\n",strerror(errno));
		return(1);
	}
	printf("Going to read from soundcard.press Ctrl+C to stop\n");
	retVal = 0;
	memset(soundBuffer,'\0',frameSize);
	while(breakLoop == 0)/* read frame by frame till ctrl+c */
	{
		bytesRead = 0;
		bytesRead = read(fd,soundBuffer,frameSize);
		if ( ( bytesRead < frameSize ) && ( breakLoop != 1 ) )
		{
			printf("Bad sound card read \n");
		}
		else
		if ( breakLoop != 1  )
		{
		    retVal = fwrite(soundBuffer,sizeof(unsigned char),frameSize,fp);
		    if ( (retVal != frameSize ) || ( retVal != ( sizeof(unsigned char) * frameSize ) ) )
		    {
			    printf("Not All bytes were written to file\n");
		    }
		}
		/* clean the buffer */
	    memset(soundBuffer,'\0',frameSize);
	}
	printf("All done cleaning up\n");
	if ( ( retVal = close(fd) ) < 0 )
	{
		printf("Error on closing sound card's descriptor\n");
		printf("Error reason = %s\n",strerror(errno));
	}
	free(soundBuffer);
	soundBuffer = NULL;
	fclose(fp);
	printf("Trying to write back to the sound card\n");
	errno = 0;
	if ( ( fd = open("/dev/dsp",O_WRONLY) ) < 0 )
	{
		printf("Unable to opne sound card for writing\n");
		printf("Error reason = %s\n",strerror(errno));
		return(1);
	}
	if ( ( fp = fopen("./audiobuf","r") ) == NULL )
	{
		printf("Unable to open the audio file\n");
		printf("Error reason = %s\n",strerror(errno));
		return(1);
	}
	if ( ( fp = fopen("./audiobuf","r") ) == NULL )
	{
		printf("Unable to open the audio file\n");
		printf("Error reason = %s\n",strerror(errno));
    	if ( ( retVal = close(fd) ) < 0 )
    	{
    		printf("Error on closing sound card's descriptor\n");
    		printf("Error reason = %s\n",strerror(errno));
    	}
		return(1);
	}
	format = AFMT_S16_LE;
	retVal =  ioctl(fd,SNDCTL_DSP_SETFMT,&format);
	if ( ( retVal < 0 ) || ( format != AFMT_S16_LE ) )
	{
		printf("Unable to set ioctl for audio format\n");
		if ( format == AFMT_S16_LE )
		{
			printf("Error reason = %s\n",strerror(errno));
			errno = 0;
		}
		else
		{
			printf("Wrong Format Argument\n");
		}
	}
	retVal = ioctl(fd,SNDCTL_DSP_CHANNELS,&channel);
	if ( ( retVal < 0 ) || ( channel != 1 ) )
	{
		printf("Unable to set ioctl for audio channel\n");
		if ( channel == 1 )
		{
			printf("Error reason = %s\n",strerror(errno));
			errno = 0;
		}
		else
		{
			printf("Wrong channel Argument\n");
		}
	}
	retVal = ioctl(fd,SNDCTL_DSP_SPEED,&samplingRate);
	if ( ( retVal < 0 ) || ( samplingRate != 8000 ) )
	{
		printf("Unable to set ioctl for sampleing rate\n");
		if ( samplingRate == 8000 )
		{
			printf("Error Reason = %s\n",strerror(errno));
		}
		else
		{
			printf("Wrong sampling rate argument\n");
		}
	}
	frameSize = samplingRate * channel * sizeof(unsigned char);
	errno = 0;
	if ( ( soundBuffer = (unsigned char *)malloc(frameSize) ) == NULL )
	{
		printf("Unable to allocate memory\n");
		printf("Error reason = %s\n",strerror(errno));
		return(1);
	}
	errno  = 0;
	/* clean the buffer */
    memset(soundBuffer,'\0',frameSize);
	while( ! feof(fp) )
	{
	    fread(soundBuffer,sizeof(unsigned char),frameSize,fp);
		if ( ! feof(fp) )
		{
		    errno = 0;
	        if ( write(fd,soundBuffer,frameSize) != frameSize )
		    {
		    	printf("Error occurred during writing\n");
		    	printf("Error reason = %s\n",strerror(errno));
		    }
		    /* clean the buffer */
	        memset(soundBuffer,'\0',frameSize);
		}
	}
	if ( ( retVal = close(fd) ) < 0 )
	{
		printf("Error on closing sound card's descriptor\n");
		printf("Error reason = %s\n",strerror(errno));
	}
	printf("All Done\n");
	free(soundBuffer);
	soundBuffer = NULL;
	fclose(fp);
	return(0);
}

ya i know the code is not optimized but then i was just testing it anyway.
the catch is i want to know whether i can read data from the soundcard and write back to it without doing any encoding.
the above code is not working.
any clues/pointers would be greatly appreciated.
Thanks
K.Shyam


________________________________________________________
Outgrown your current e-mail service?
Get a 25MB Inbox, POP3 Access, No Ads and No Taglines with LYCOS MAIL PLUS.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
