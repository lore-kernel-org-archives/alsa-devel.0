From: Fred Gleason <fredg@salemradiolabs.com>
Subject: Re: (no subject)
Date: Wed, 25 Jun 2003 22:46:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306252246.23321.fredg@salemradiolabs.com>
References: <20030625174034.22204.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030625174034.22204.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 25 June 2003 20:40, Eliot Blennerhassett wrote:

> Try aplay -Dhw:0,0,1

Works, as does hw:0,0,2 and hw:0,0,3.  Curiously, hw:0,0,4 returns EBUSY, not 
ENODEV as I would have expected.  Is this a normal feature of ALSA?


> For ALSA the card has one device, and multiple subdevices.
> This reflects that HW having one DSP handling multiple streams.
> (The number of devices is limited to 4 I think)

OK.


> > but of course requires a static major number assignment.  Perhaps this is
> > the way we'll have to go, and just continue to use a number from the
> > 'local/experimental' range.
>
> I'm open to any suggestions here.  I don't know enough about what the
> options are.

Just keep mapping it to major 254 for the time being, I think.  The real 
answer is DevFS, but I don't see the major distros shipping with that enabled 
until kernel 2.6 hits.  If then.

In the meantime, this does imply that the base linuxhpk should be changed to 
use a standard kmod-type setup, rather than the 'asihpiload'/'asihpiunload' 
scripts.  I guess that means directions for modifying 'modules.conf', please 
a script to make the /dev/hpi device.

Cheers!


|-------------------------------------------------------------------------|
|      Frederick F. Gleason, Jr.      |         Salem Radio Labs          |
|       Voice: 1-(540)-341-2880       |      87 Lee Highway, Suite 11     |
|        FAX: 1-(540)-341-7176        |        Warrenton, VA 20188        |
|-------------------------------------------------------------------------|
|                       Patch griefs with proverbs.                       |
|                                      -- William Shakspeare              |
|                                         "Much Ado About Nothing"        |
|-------------------------------------------------------------------------|



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
