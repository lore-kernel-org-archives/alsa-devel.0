From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question: setting up the hardware for alsa
Date: Mon, 07 Nov 2005 11:26:44 +0100
Message-ID: <1131359204.436f2be439fc8@webmail.uni-halle.de>
References: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Smoot <davidsmoot@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Smoot wrote:
> 3. made scripts to make my device nodes
> mknod /dev/mixer c 14 0
> ...

ALSA devices are in /dev/snd/; see the snddevices script in the alsa-driver
package.

> 4. Made another script to load my kernel modules
> /run/tools/insmod soundcore.ko
> ...

If you use the OSS emulation (/dev/dsp etc.), you have to load the snd-xxx-oss
modules.


HTH
Clemens


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
