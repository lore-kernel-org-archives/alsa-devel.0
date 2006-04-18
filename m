From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS-EMULATION bug?
Date: Tue, 18 Apr 2006 14:18:39 -0400
Message-ID: <1145384320.23853.40.camel@mindpipe>
References: <4445012F.1070400@riccardotempesta.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4445012F.1070400@riccardotempesta.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Riccardo Tempesta <info@riccardotempesta.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-18 at 17:09 +0200, Riccardo Tempesta wrote:
> I tried to compile alsa-driver-1.0.11rc4 with dynamic minors to allow 
> more than 8 soundcards.
> I connected 12 audio devices and it worked perfectly as alsa, but I can 
> find only 8 dsp under "/dev".
> 
> Is it a bug?

Could be udev/hotplug issue.  If you create the last 4 by hand with
mknod do they work?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
