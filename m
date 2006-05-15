From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Mix audio at different frequencies
Date: Mon, 15 May 2006 14:16:56 +0100
Message-ID: <44687F48.7080204@superbug.co.uk>
References: <1147429541.26309.3.camel@jazc.fedora>	<s5hpsijzbof.wl%tiwai@suse.de>	<1147676786.2963.1.camel@jazc.fedora>	<s5h4pzrwqp0.wl%tiwai@suse.de>	<000601c67812$4b80e240$8ca8a8c0@gmvsistemas.es> <s5hu07r1q0o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu07r1q0o.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Juan Antonio Zapatero Campo <jazc@gmvsistemas.es>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 15 May 2006 13:25:39 +0200,
> Juan Antonio Zapatero Campo wrote:
>   
>> No, it returns wrong buffer sizes. Instead of 160 samples, which is what I 
>> am expecting at 8000Hz, it returns a value of 341, which I do not 
>> understand.
>>     
>
> You cannot get always the exactly same buffer size you requested.
> Especially dmix limits the buffer size to its own and rate plugin
> rescales the size according to the rate conversion.
>
>
> Takashi
>   
I would argue that maybe we should modify the way alsa behaves, and 
somehow get dmix to work with user(application) defined buffer and 
period sizes.
I.e. Let alsa handle whatever buffer and period size the user 
application wants, and get ALSA to translate it into the sized needed 
for the hardware.
Maybe implement the use of the system timer in order to trigger the 
buffer events we need.

James



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
