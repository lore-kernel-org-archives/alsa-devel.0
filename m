From: Thomas Charbonnel <thomas@undata.org>
Subject: Questions to HDSP users
Date: Wed, 28 Jan 2004 16:29:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4017D54D.2020502@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (brln-d9b80d49.pool.mediaWays.net [217.184.13.73])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA18286
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2004 17:05:22 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

In the process of debuging the problems some hdsp users are 
experiencing, I reviewed almost every single line of code in the hdsp 
driver, and there are things in there that were inherited from the old 
rme9652 driver and that don't seem relevant anymore for the hdsp 
(particularly now that hdspmixer is there).
* Does anyone use the passthru control ? If not I would gladly remove it 
as it interferes with hdspmixer. Anyway everything it did can be done 
with hdspmixer or the Mixer control using a shell script.
* The current behaviour is that the driver cancels any 1:1 input to 
output routing when playback or capture is enabled. Not only this 
interferes with hdspmixer, but I find it rather confusing. Any objection 
to a change here also ?

I also realized communicating with RME that the firmware files we use in 
linux are not the same as those used in current versions of the windows 
and mac drivers. As a consequence people using dual boot systems should 
always power cycle their iobox when switching operating systems to 
prevent any problem (this is of particular importance to rev 0xa users).
This minor issue will be resolved shortly as I'm working on switching to 
those files for the linux driver. The new firmware files seem to be 
revision independant (but they do require a driver modification) and add 
support for disconnect mode (standalone operation of the iobox - I have 
it working here, it's awesome !)

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
