From: Sven Geggus <sven@geggus.net>
Subject: Re: Bug: aplay/alsa-lib problem on mips (openwrt,
	uclibc)
Date: Thu, 24 Aug 2006 16:55:21 +0000 (UTC)
Message-ID: <eckllp$94a$1@ultimate100.geggus.net>
References: <eciaah$qi9$1@ultimate100.geggus.net>
	<Pine.LNX.4.61.0608241435580.5772@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> wrote:

> This value looks bogus. Try compile alsa-lib with --with-debug=yes and 
> try 'LIBASOUND_DEBUG=1 aplay ...other arguments...'. Perhaps, it shows 
> more...

It does show a little bit more:
root@FreeWRT:/usr/lib#  /usr/local/bin/aplay -f cd -t raw
</dev/urandom
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
ALSA lib pcm.c:878:(snd_pcm_sw_params) params->avail_min is 0
aplay: set_params:1012: unable to install sw params:
start_mode: EXPLICIT
xrun_mode: NONE
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 718523216
silence_threshold: 0
silence_size: 0
boundary: 1073741824

Sven

-- 
Kernel panic: I have no root and I want to scream
(Linux Kernel Error Message)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
