From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: some problem in wm9712 driver
Date: Mon, 18 Sep 2006 18:03:49 +0100
Message-ID: <1158599029.4707.8.camel@localhost.localdomain>
References: <DBC923D919FAB345973A94E6E194E8490353C38C@yvrmail01.itc.intrinsyc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <DBC923D919FAB345973A94E6E194E8490353C38C@yvrmail01.itc.intrinsyc.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Luke Zhang <lzhang@intrinsyc.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-09-18 at 09:49 -0700, Luke Zhang wrote:
> Hello everyone,
> 
>  
> 
> I found some problem in wm9711_snd_ac97_controls[] of ac97_patch.c.  
> 
>  
> 
> For example, for the interface AC97_SINGLE("Mic 1 Volume", AC97_MIC,
> 8, 32, 1), here the mask is set as 32, but the MIC1 volume field in
> Reg 0eh occupies 8-12 bits.  So it means if I set the MIC1 volume as
> 32 using amixer command, it will affect M22P bit actually.
> 
>  

That's a bug. 32 should be 31. I'll create a patch for this.


> 
> Another, for the interface AC97_DOUBLE("Capture Volume",
> AC97_REC_GAIN, 8, 0, 15, 1), here the mask is 15, but RECVOLL and
> RECVOLR occupies 6 bits individually.  So if I set capture volume as
> 32, the actual value will be 15 instead.
> 
>  
> 

This one is intentional (I was concerned about userspace legacy app
compatibility). The standard AC97 register map defines REC_GAIN as 4
bits. However, the WM9712 extends this and gives 2 extra bits of gain.
Have you tried changing this to 63 (6 bits)? 

I would be interested to know if everything in userspace worked as
expected (for 6 bits), if so I'll create a patch that extends it to 6
bits.

Thanks

Liam




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
