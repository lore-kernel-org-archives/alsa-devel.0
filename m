From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: About my Live! 5.1
Date: Sun, 27 Nov 2005 16:50:25 -0500
Message-ID: <1133128226.19505.2.camel@mindpipe>
References: <43875FC3.9040408@demiart.ru>
	 <200511261040.47678.alien999999999@users.sourceforge.net>
	 <1133029953.5904.4.camel@mindpipe>
	 <200511272120.42279.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200511272120.42279.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alien <alien999999999@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net, Alexandr <spiro@demiart.ru>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-11-27 at 21:20 +0100, Alien wrote:
> Op zaterdag 26 november 2005 19:32, schreef Lee Revell:
> > On Sat, 2005-11-26 at 10:40 +0100, Alien wrote:
> > > I too have the SB0220
> >
> > Do you have the same problem with the mixer as Alexandr?
> 
> no, but then i have an old CVS version and i didn't apply the patch.
> 
> more than that, it's my second soundcard, but 'alsamixer -c 1' works for me, 
> i've used it alot, maybe he should do an 'alsactl store' ?
> 
> [alien@queen ~]$ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.10rc1.
> Compiled on Oct 15 2005 for kernel 2.6.11-12mdk.

I believe there's something weird about the SB022x (multiple AC97
codecs?) that the driver does not handle properly.  The changelog for
the kX driver 3538 mentions "SB022x fixes".

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
