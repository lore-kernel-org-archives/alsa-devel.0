From: "mahendra  sp" <mahendra_sp@rediffmail.com>
Subject: Playback underrun
Date: 5 Jul 2003 12:52:28 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030705125228.31781.qmail@mailweb33.rediffmail.com>
Reply-To: "mahendra  sp" <mahendra_sp@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
Cc: James@superbug.demon.co.uk, raphael@math.umass.edu
List-Id: alsa-devel@alsa-project.org

hi,
   i am using alsa0.9.4

   i have written an application which works fine .but there is 
buffer underun problem .but it corrects itself after some time. i 
ant to overcome this problem.

please help.

   i am here by attaching the program for verification.

i am setting :
#define PERIODSIZE 512
#define BUFSIZE 512 * 4
int format = SND_PCM_FORMAT_S16_LE
snd_pcm_uframes_t buffer_size = PERIODSIZE * 4
snd_pcm_uframes_t period_size  = PERIODSIZE
/* user buffer*/
char buf[BUFSIZE * 10];

    Can anybody please explain as i am setting period_size = 512 , 
bufsize = 512*4, am i reading(readi)  2048 bytes? or 2048 
frames?
   whts the diffrence between frames and bytes?
    while writing (writei)  do i need to convert  betwenn bytes 
and frames
   please explain whats this period_size and buffer_size. And alsa 
is it necessory to keep application buffer to collect the sound as 
buf[BUFSIZE *10]?
   if i want to read only 256 bytes with out any underrun or 
overrun to what values i must set buffer_size and period_size ? 
and also what should be the minimum size of application buf.?

   And also if i am integrating this  with RTP, i am getting 
broken pipe error while reading . But with out RTp it works fine. 
Whats the reason?

  thanks,
regards








___________________________________________________
Click below to experience Sooraj R Barjatya's latest offering
'Main Prem Ki Diwani Hoon' starring Hrithik, Abhishek
  & Kareena http://www.mpkdh.com



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
