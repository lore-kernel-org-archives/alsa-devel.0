From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 03:41:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030711014158.GA29151@alinoe.com>
References: <20030710234320.GA21216@alinoe.com> <Pine.LNX.4.44.0307110251390.5612-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307110251390.5612-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net, xvoice@yahoogroups.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 11, 2003 at 03:05:28AM +0300, Kai Vehmanen wrote:
> One thing to try is the alsa-oss package. This is an alternative
> (user-space) implementation of the OSS emulation layer. It relies on the
> LD_PRELOAD mechanism. You can test it with:
> 
> LD_PRELOAD=/path/to/libaoss.so.0.0.0 ./a.out
> 
> ... where "a.out" is your test program. You should be able to run ViaVoice
> also this way. You can get the alsa-oss package from ALSA CVS or from:
> LD_PRELOAD=~/src/alsa-cvs/alsa-oss/.libs/libaoss.so.0.0.0 ./a.out

Thanks, this is very useful.

I downloaded the source of ALSA from CVS.
It turns out that I cannot compile it: I have kernel 2.5.74
and the alsa source (alsa-drivers and alsa-kernel) is full
of 'spin_lock_*' function calls that do not exist in kernel 2.5.

Nevertheless, I could compile the alsa-oss library.

This turns out not to be blocking anymore - but, the result of
a SNDCTL_DSP_GETISPACE is unfortunately nonsense :(

I now get:

~>LD_PRELOAD=/usr/src/alsa/alsa-oss/.libs/libaoss.so.0.0.0 a.out
Fragment size: 1024
Number of fragments: 32767
Number of channels: 1
Sample rate: 22050
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 2048
Number of bytes that can be read or written immediately without blocking: 1024
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 2048
Number of bytes that can be read or written immediately without blocking: 1024
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 2048
Number of bytes that can be read or written immediately without blocking: 1024
Number of full fragments that can be read or written without blocking: 0
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 2048
Number of bytes that can be read or written immediately without blocking: 1024
Number of full fragments that can be read or written without blocking: 1
Total number of fragments allocated for buffering: 2
Size of a fragment in bytes: 2048
Number of bytes that can be read or written immediately without blocking: 3072
Read 1024 bytes.
etc

The size of a fragment is NOT 2048... it is 1024.
It also reports 3072 bytes available, which is more than the total size of the buffer!

I am not sure what the application will do with mis-information like this.

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
