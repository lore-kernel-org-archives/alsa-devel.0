From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Wed, 09 Aug 2006 10:26:35 +0200
Message-ID: <20060809102635.d12eh571icwkwg0c@webmail.supelec.fr>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808202335.1ypdlgq4tckkcwg4@webmail.supelec.fr>
	<m2fyg6a94o.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <m2fyg6a94o.fsf@vador.mandriva.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> For instance I had to introduce the device_setup module parameter in
>> order to make my Audiophile USB pre-select 16bits OR 24bits mode
>> because switching between the two modes while the device is turned
>> on doesn't work:
>
> is it a linux kernel limitation or an harware issue (eg does switching
> fork under windows)?

Difficult to say...

The Audiophile USB manual for Windows says that it is required to close 
any application when switching sample depth modes in the M-Audio 
Control Panel: but it is not necessary to turn off/on the device under 
windows.

Under linux however, it is necessary to turn the device off, then 
initialize the module to only activate the Interfaces/AltSettings 
corresponding to the sample depth chosen and then turn on the device 
again !

I checked the USB messages sent and it seems that they are "equivalent" 
in windows/linux: I mean all Interfaces/AltSet are initialized to 
AltSet 0 then the Interfaces/AltSettings corresponding to the sample 
depth chosen are activated with a SELECT_INTERFACE message. However 
under windows when switching modes, there are 'sometimes' (I haven't 
investigated enough to analyze this)several AltSet resettings 
(Interfaces/AltSet initialized to AltSet 0) before setting again the 
correct Interfaces/AltSet.

I tried several patches in order to avoid this limitation (reset the 
usb device, reset all interfaces to AltSet 0 several times before 
re-setting them...) but nothing proved to be usefull for this issue.

Even if there is a hardware limitation, we should be able to avoid the 
Turn Off/On limitation by better looking at the windows driver...

Thibault


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
