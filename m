From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp patch, version II
Date: 05 Mar 2003 10:02:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046854925.1721.11.camel@satellite.undata.org>
References: <200303042322.h24NMSZ04964@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303042322.h24NMSZ04964@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-03-05 at 00:22, Paul Davis wrote:
> This is a new version of the previous patch, but now also includes:
> 
>     * use of udelay to force timed loops rather than count-based loops
>     * fix hdsp_is_9652()
>     * don't include unnecessary playback mixer controls for Multiface
>     * don't attempt to download firmware to HDSP9652 systems (its
>         not the right thing to do, apparently)
>      
> --p
> 

I'm experiencing complete system lockups with this, in every possible
situation:
* cold boot
* reboot
* post boot module insertion

I did power off the card after updating, so the firmware has to be
loaded.

I get no message from the driver.

No timeout ever occurs. (I left the machine hanging for at least 10
minutes)

My system: 
Kernel 2.4.20 ck3
Alsa-driver 9.0rc8 + hdsp patch II applied
Cardbus + multiface

Thomas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
