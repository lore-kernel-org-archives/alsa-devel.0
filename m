From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] [linux-audio-user] Re: More Midisport 2x2
 troubles (help from the Alsa developers is greatly appreciated!)
Date: Fri, 04 Apr 2003 08:30:28 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304040825100.29327-100000@studcom.urz.uni-halle.de>
References: <000001c2fa4e$91c5af00$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <000001c2fa4e$91c5af00$ac1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ivica Bukvic wrote:
> Hmm, I've tried running the alsa-lib/test/ramidi test and tried using it
> as:
> rawmidi -i hw:2,0
> ...
> Any other setting (i.e. hw:2,1) reports an error that such a device was
> not found.

The first number is the card number, the second is the device number, and
the third is the subdevice number. Your two ports are "hw:2,0,0" and
"hw:2,0,1", respectively.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
