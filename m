From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Possible solution for the alsa-oss fopen problem.
Date: Wed, 09 Jun 2004 12:10:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C6F035.4000406@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-37.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 69AC21C6
	for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2004 13:10:37 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-37.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BY0ya-0006Eg-0b
	for alsa-devel@alsa-project.org; Wed, 09 Jun 2004 12:10:36 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have found out that the artsdsp /dev/oss redirector supports fopen and 
friends.
I looked at the artsdsp, (find it inside arts-1.2.2.tar.bz2)
It uses a function called fopencookie()

Extract from /arts-1.2.2/artsc/stdioemu.c below.

Would this be useable in the alsa-oss redirector?

Cheers
James



static FILE *fake_fopen(const char *path, const char *mode)
{
         cookie_io_functions_t fns = { fdc_read, fdc_write, fdc_seek, 
fdc_clean };
         struct fd_cookie *fdc =
                 (struct fd_cookie *)malloc(sizeof(struct fd_cookie));
         const char *mptr;
         int open_mode = 0;
         FILE *result = 0;

         for(mptr = mode; *mptr; mptr++)
         {
                 if(*mptr == 'r') open_mode |= 1; /* 1 = read */
                 if(*mptr == 'w') open_mode |= 2; /* 2 = write */
                 if(*mptr == '+') open_mode |= 3; /* 3 = readwrite */
                 if(*mptr == 'a') open_mode |= 2; /* append -> write */
         }
         if(open_mode == 1) fdc->fd = open(path,O_RDONLY,0666);
         if(open_mode == 2) fdc->fd = open(path,O_WRONLY,0666);
         if(open_mode == 3) fdc->fd = open(path,O_RDWR,0666);

         if(open_mode && fdc->fd > 0)
         {
                 result = fopencookie (fdc,"w", fns);
                 result->_fileno = fdc->fd;              /* ugly patchy 
slimy kludgy hack */
         }
         return result;
}


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
