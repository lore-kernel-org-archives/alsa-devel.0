From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Thu, 10 Jul 2003 14:15:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F0D66ED.3090509@superbug.demon.co.uk>
References: <20030710013326.GA12086@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030710013326.GA12086@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Carlo Wood wrote:
> I pinpointed the problem and wrote a small program
> to illustrate the problem.
> 
> When compiling the program given below with:
> 
>   gcc -DUSE_DSP_SETFMT=0 troep.c
> 
> it runs fine.
> 
> But, when compiling it with:
> 
>   gcc -DUSE_DSP_SETFMT=1 troep.c
> 
> It stops rather quickly with reading data.
> 
> Example output of the latter:
> 
> ~>a.out
> Fragment size: 1024
> Number of fragments: 32767
> Number of channels: 1
> Sample rate: 22050
> Read 1024 bytes.
> Number of full fragments that can be read or written without blocking: 0
> Total number of fragments allocated for buffering: 2
> Size of a fragment in bytes: 1024
> Number of bytes that can be read or written immediately without blocking: 0
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 1, 1632
> Read 1024 bytes.
> #fragments, #bytes: 2, 2048
> Read 1024 bytes.
> #fragments, #bytes: 1, 1024
> Read 1024 bytes.
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 0, 0
> #fragments, #bytes: 0, 0
> ...etc
> 
Why don't you just use /proc/asound to gather all the info you need, 
like buffer and period sizes.
E.g.
While playing a sound file: -
cat /proc/asound/oss/sndstat
cat /proc/asound/card0/pcm0p/info

cat /proc/asound/card0/pcm0p/sub0/hw_params
cat /proc/asound/card0/pcm0p/sub0/info
cat /proc/asound/card0/pcm0p/sub0/status
cat /proc/asound/card0/pcm0p/sub0/sw_params

If recording a sound, use pcm0c instead of pcm0p

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
