From: Marcelo Utikawa da Fonseca <marcelo.fonseca@tecnequip.com.br>
Subject: Re: Problem compiling soc - imx31 and wm8753
Date: Wed, 11 Mar 2009 14:08:44 -0300
Message-ID: <49B7F01C.2070202@tecnequip.com.br>
References: <49B7CEFD.1080006@tecnequip.com.br>
	<20090311153554.GB15629@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3279581157203684699=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hm1315-16.locaweb.com.br (hm1315-16.locaweb.com.br
	[201.76.49.64]) by alsa0.perex.cz (Postfix) with ESMTP id 546C710387E
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 18:08:47 +0100 (CET)
Received: from hm574.locaweb.com.br (10.1.10.44) by hm1315-16.locaweb.com.br
	(PowerMTA(TM) v3.5r11) id hmvo1u0nvfo0 for
	<alsa-devel@alsa-project.org>;
	Wed, 11 Mar 2009 14:08:44 -0300 (envelope-from
	<marcelo.fonseca@tecnequip.com.br>)
In-Reply-To: <20090311153554.GB15629@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3279581157203684699==
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The i.MX31 Freescale's BSP does not have asoc support, just an interface 
for MC13783 (a Power Management IC from Freescale with integrated audio 
interface).
The wolfsonmicro's tree is the only one that have support to asoc but it 
does not compiles using the mentioned steps.
Am I missing something or may be these drivers broken?

Mark Brown escreveu:
> On Wed, Mar 11, 2009 at 11:47:25AM -0300, Marcelo Utikawa da Fonseca wrote:
>
>   
>> I am facing a problem while compiling the sound support for imx31ads board.
>> I got the kernel from wolfsonmicro using the following command:
>>     
>
>   
>> git clone git://opensource.wolfsonmicro.com/linux-2.6-asoc linux-2.6-asoc
>>     
>
>   
>> After this I just copy the arch/arm/configs/mx31ads_defconfig to .config 
>> and run:
>>     
>
>   
>> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- menuconfig
>>     
>
>   
>> I did not change nothing, just configure and compile...
>> My gcc version is 4.1.2 from Freescale.
>> What can be wrong? Could be this version of gcc a problem?
>> I already tried to correct the missing include files but the other 
>> errors are still there after the corrections...
>>     
>
> The i.MX31 support that is present in ASoC git depends on underlying
> support for the CPU which is not present in any mainline tree (which is
> why this code has not been contributed to mainline yet).
>
> Probably the easiest thing to do is to start from the BSP provided by
> Freescale - I believe that most versions of that contain the CPU audio
> drivers already, probably including a version of the WM8731 driver.  It
> should be much easier to merge that driver (by itself, just wm8731.c and
> wm8731.h) into the Freescale BSP than to merge the i.MX31 support into
> the standard kernel.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>   


---------------------------------------------
Tecnequip Tecnologia em Equipamentos
Endereço/Address: Rua Juno, 527
Cidade/City: São Paulo
Estado/State: SP
País/Country: Brasil
CEP/Postal Code: 03445-000
Fone/Phone: 55-11-20937199
FAX: 55-11-29412289

--===============3279581157203684699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3279581157203684699==--
