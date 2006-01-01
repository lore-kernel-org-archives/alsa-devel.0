From: Brent Cook <busterbcook@yahoo.com>
Subject: Re: Support for EDIROL UM-3ex
Date: Sat, 31 Dec 2005 22:06:18 -0600
Message-ID: <200512312206.18365.busterbcook@yahoo.com>
References: <200512312154.35173.busterbcook@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200512312154.35173.busterbcook@yahoo.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Saturday 31 December 2005 21:54, Brent Cook wrote:
> Dear all,
>
> This is my naive attempt at adding ALSA device support. The attached patch
> provides support for the EDIROL UM-3ex. This is a 3-port USB midi interface
> with a built-in USB hub and the ability to chain 2 other UM-3x's in a
> master-slave configuration. I only have one, so I do not know how this
> works in practice.
>
> Though this is a 3-port device, I had to throw in that 4th 'Control'
> interface to the definition in order to make the 3rd port work. If I set
> in/out_cables to 0x000b, a 3rd interface appears on the driver, but it does
> nothing. Changing it to 0x000f allows the 3rd interface to work, but of
> course interface 4 does not work because it does not exist.
>
>  - Brent

Oh, and here is the relevant USB info for the device; maybe it explains the 
3rd port quirk.

T:  Bus=04 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=ff MxPS=64 #Cfgs=  1
P:  Vendor=0582 ProdID=009a Rev= 1.00
S:  Manufacturer=EDIROL
S:  Product=UM-3
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr= 90mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=03 Prot=00 Driver=snd-usb-audio
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 0 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=03 Prot=00 Driver=snd-usb-audio
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=1ms


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
