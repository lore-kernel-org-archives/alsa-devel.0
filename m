From: "mahendra  sp" <mahendra_sp@rediffmail.com>
Subject: Alsa Fullduplex and VoIP
Date: 23 Jun 2003 15:11:02 -0000
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20030623151102.8046.qmail@webmail25.rediffmail.com>
Reply-To: "mahendra  sp" <mahendra_sp@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <alsa-user-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: tiwai@suse.de, alsa-user@alsa-project.org, alsa-devel@lists.sourceforge.net, perex@suse.cz, mana@suse.de, ilyaphis@mail.ru, paul@linuxaudiosystems.com, alsa@zevv.nl
List-Id: alsa-devel@alsa-project.org

hi,
  this is the program which is a improved version of program 
written by  whicxh was posred in this mail.So , this program 
transfers Voice over IP. but There is no synchronisation. Can any 
body tell solutio for these issues:

1. How to make server which is actiong as a playback program waits 
and plays in order the packets received from the client.
2. sychonisation issue.
3. How to over come the buffer xrun in case of playback?

i really thank Mr. for writing this fine program so that i could 
extend it.
thank u ,
and waiting for ur assisatnce,

*************************************************************
Client.c  captures and sends tyhe packets  to the server
**********************************************************
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <resolv.h>
#include <netinet/in.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <netdb.h>

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include "../include/asoundlib.h"

#define DEST_PORT 9999
#define PERIODSIZE 512
#define BUFSIZE (PERIODSIZE *4)

int sock_cli;
char SERV_IP[15] = "10.115.3.131";
struct sockaddr_in cli_addr;

int samplerate = 22050;
int channels = 2;
int accessmode = SND_PCM_ACCESS_RW_INTERLEAVED;
int format = SND_PCM_FORMAT_S16_LE;
int periods = 4;
snd_pcm_uframes_t buffer_size = PERIODSIZE * 4;
snd_pcm_uframes_t period_size  = PERIODSIZE;
snd_output_t *output = NULL;

#define checkr(r) if (r <0) { \
 	fprintf(stderr,"%s\n",snd_strerror(r));\
 		exit(-1);\
                      }

     int tcpip_init(void)
{


 	if((sock_cli = socket( AF_INET,SOCK_STREAM,0)) < 0)
 	{
 		perror("can not create socket\n");
 		exit(1);
 	}

 	bzero(&cli_addr,sizeof(cli_addr));
 	cli_addr.sin_family = AF_INET;
 	cli_addr.sin_port = htons(DEST_PORT);

 	if(inet_pton(AF_INET,SERV_IP,&cli_addr.sin_addr) == 0)
 	{
 		perror("can not be converted\n");
 		exit(1);
 	}

 	if(connect(sock_cli,(struct 
sockaddr*)&cli_addr,sizeof(cli_addr)) < 0)
 	{
 		perror("error in connecting\n");
 		exit(1);

 	}
 	else printf("connection successful, connected to server\n");

 	return 0;
}

int set_hw_params(snd_pcm_t *handle)
{
 	int r;
 	snd_pcm_hw_params_t *hwparams;
 	snd_pcm_sw_params_t *swparams;

 	r = snd_pcm_hw_params_malloc(&hwparams);checkr(r);

 	r = snd_pcm_hw_params_any(handle,hwparams);checkr(r);

 	r = 
snd_pcm_hw_params_set_access(handle,hwparams,accessmode);checkr(r);

 	r = 
snd_pcm_hw_params_set_format(handle,hwparams,format);checkr(r);

 	r = 
snd_pcm_hw_params_set_channels(handle,hwparams,channels);checkr(r);

 	r = 
snd_pcm_hw_params_set_rate_near(handle,hwparams,&samplerate,0);checkr(r);

 	r = 
snd_pcm_hw_params_set_periods(handle,hwparams,periods,0);checkr(r);

 	r = 
snd_pcm_hw_params_set_buffer_size_near(handle,hwparams,&buffer_size);checkr(r);

 	r = 
snd_pcm_hw_params_set_period_size_near(handle,hwparams,&period_size,0);checkr(r);

 	r = snd_pcm_hw_params(handle,hwparams);checkr(r);

 	r = snd_pcm_sw_params_malloc(&swparams);checkr(r);

 	r = snd_pcm_sw_params_current(handle,swparams);checkr(r);

 	r = 
snd_pcm_sw_params_set_avail_min(handle,swparams,period_size);checkr(r);

 	r = snd_pcm_sw_params(handle,swparams);checkr(r);

 	snd_pcm_prepare(handle);

 	return 0;

}

int main()
{

 	short buf[BUFSIZE * 10];
 	int r,i;
 	snd_pcm_t *pcmc;
 	r = 
snd_pcm_open(&pcmc,"plughw:0,0",SND_PCM_STREAM_CAPTURE,0);checkr(r);
 	set_hw_params(pcmc);

 	tcpip_init();

 	while(1)
 	{

 		r = snd_pcm_readi(pcmc,buf,BUFSIZE);

 		if(r == BUFSIZE)printf("record r = %d\n",r);

 		else {
 			printf("record r = %d\n",r);
 			checkr(r);
 	              }

 		r = send(sock_cli,buf,BUFSIZE,0);
   		if(r <  0)
 		{
 			printf("socket send error\n");
 			close(sock_cli);
 			exit(-1);
 		}
 		else printf("sent bytes %d\n",r);
 		for(i = 0;i<100;i++);

 	}


 	//else 	printf("no of bytes sent %d",result);

         close(sock_cli);
 	snd_pcm_close(pcmc);

         return 0;
}
******************************************************
server.c waits for packets and plays them
*****************************************************

#include<stdio.h>
#include<string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <resolv.h>
#include  <errno.h>
#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include "../include/asoundlib.h"
#define BIND_PORT  9999
#define BACK_LOG   5
#define PERIODSIZE 512
#define BUFSIZE (PERIODSIZE * 4)

#define checkr(r) if(r<0) { \
 	fprintf(stderr,"%s \n",snd_strerror(r));\
 		exit(-1);\
 		}
int serv_sock,
     new_sock;
struct sockaddr_in server_addr,local_addr;

/* new */
int samplerate =  22050;
int channels =  2;
int accessmode = SND_PCM_ACCESS_RW_INTERLEAVED;
int format =  SND_PCM_FORMAT_S16_LE;
int periods = 4;

snd_pcm_t *pcmp;
snd_pcm_uframes_t buffer_size = PERIODSIZE * 4;
snd_pcm_uframes_t period_size = PERIODSIZE;
snd_output_t *output = NULL;


int tcpip_init()
{

 	int len;

 	if (( serv_sock = socket( AF_INET,SOCK_STREAM,0 )) < 0)
 	{
 		perror("can not open server socket\n");
 		abort();
 	}

 	bzero(&server_addr,sizeof(server_addr));
 	server_addr.sin_family = AF_INET;
 	server_addr.sin_port =  htons( BIND_PORT);
 	server_addr.sin_addr.s_addr = INADDR_ANY;


 	if(bind(serv_sock,(struct 
sockaddr*)&server_addr,sizeof(server_addr)) < 0)
 	{
 		perror(" error in binding\n");
 		abort();
 	}

 	if(listen(serv_sock,BACK_LOG) < 0)
 	{
 		perror(" error in listen\n");
 		abort();
 	}
 	else printf("listening\n");

 	len = sizeof(local_addr);
 	new_sock = (accept(serv_sock,(struct sockaddr 
*)&local_addr,&len));

 	if (new_sock == ( EBADF|| ENOTSOCK ||EOPNOTSUPP))
 		printf("not a valid one\n");
 	else
 		printf("accepted 
client:%s\n",inet_ntoa(local_addr.sin_addr));

 	return 0;
}


int set_hw_params(snd_pcm_t *handle)
{
 	int r;
 	snd_pcm_hw_params_t *hwparams;
 	snd_pcm_sw_params_t *swparams;

 	r = snd_pcm_hw_params_malloc(&hwparams);checkr(r);

 	r = snd_pcm_hw_params_any(handle,hwparams);checkr(r);

 	r = 
snd_pcm_hw_params_set_access(handle,hwparams,accessmode);checkr(r);

 	r = snd_pcm_hw_params_set_format(handle,hwparams,format); 
checkr(r);

 	r  = 
snd_pcm_hw_params_set_channels(handle,hwparams,channels);checkr(r);

 	r = 
snd_pcm_hw_params_set_rate_near(handle,hwparams,&samplerate,0);checkr(r);

 	r = snd_pcm_hw_params_set_periods(handle,hwparams,periods,0); 
checkr(r);

 	r = 
snd_pcm_hw_params_set_buffer_size_near(handle,hwparams,&buffer_size);checkr(r);

 	r = 
snd_pcm_hw_params_set_period_size_near(handle,hwparams,&period_size,0);checkr(r);

 	r = snd_pcm_hw_params(handle,hwparams);checkr(r);

 	r = snd_pcm_sw_params_malloc(&swparams);checkr(r);

 	r = snd_pcm_sw_params_current(handle,swparams);checkr(r);

 	r = 
snd_pcm_sw_params_set_avail_min(handle,swparams,period_size);checkr(r);

 	r = snd_pcm_sw_params(handle,swparams);checkr(r);

 	snd_pcm_prepare(handle);

 	return 0;
}

int main (void)
{

 	short buf[BUFSIZE*10];
 	int r ,i;
 	snd_pcm_t *pcmp;

 	r = 
snd_pcm_open(&pcmp,"plughw:0,0",SND_PCM_STREAM_PLAYBACK,0);checkr(r);
 	set_hw_params(pcmp);

 	tcpip_init();

 	while(1)
 	{
 		for(i = 0;i<100;i++);
 		 r = recv(new_sock,buf,BUFSIZE,0);
 		if(r <0){
 			perror("socket recv error\n");
 			printf("%d\n",r);}

 		else
 		{
 			printf("bytes received %d\n",r);
 			r = snd_pcm_writei(pcmp,buf,BUFSIZE);
 			if( (r == -EPIPE) || (r<0))
 		              snd_pcm_prepare(pcmp);
 			if((r != BUFSIZE) ||  (r== BUFSIZE))
 				printf("playback r = %d\n",r);
 			//else checkr(r);


 		}

 	}

//	snd_pcm_drain(write_handle);
//	snd_pcm_close(write_handle);

 	snd_pcm_close(pcmp);
 	close(new_sock);
 	close(serv_sock);


 	return 0;
}



___________________________________________________
Get www. mycompany .com and 5 matching email ids.
Just Rs. 1499/ year.
Click here http://www.rediffmailpro.com



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
