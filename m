From: Martin Langer <martin-langer@gmx.de>
Subject: Re: my first usb-midi experiment ends with segmentation fault
Date: Tue, 30 Jul 2002 23:42:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020730214227.GA523@tuba.home>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de> <200207301708.07066.plcl@telefonica.net> <3D46C107.2E108CEB@ladisch.de> <20020730181834.GA494@tuba.home>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020730181834.GA494@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: clemens@ladisch.de, plcl@telefonica.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2002 at 08:18:34PM +0200, Martin Langer wrote:
> Bus 001 Device 002: ID 0a4d:008e  
>   Language IDs: none (invalid length string descriptor bf; len=0)
> Device Descriptor:
>   bLength                18

Ohhhhh, two lines of lsusb were missing in my mail. 
It has to be so (with "string descriptor X invalid ..."):


Bus 001 Device 002: ID 0a4d:008e  
  Language IDs: none (invalid length string descriptor bf; len=0)
string descriptor 1 invalid (bf bf; len=0)
string descriptor 2 invalid (bf bf; len=0)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            1 Audio
  bDeviceSubClass         0 
  bDeviceProtocol         0 
	      


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
