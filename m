From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Developer docs missing from ALSA web server - was:Re: [Alsa-devel]
 An driver error when I using aplay!
Date: Mon, 07 Jun 2004 11:44:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C44721.5000001@superbug.demon.co.uk>
References: <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roc Wu <cooloney@yahoo.com.cn>
Cc: Clemens Ladisch <clemens@ladisch.de>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Roc Wu wrote:
>>
>>>>Unable to find an usable access for 'default'
>>>>aplay: set_params:832: Sample format non
>>
>>available
>>
> 
> Yes. Thanks for your replay. Maybe I should send the
> mail to arm-linux mailist.
> 
> PS. Could you recommend some docs about the ALSA
> internals and Low level drivers? There are too many
> docs in the www.alsa-project.org, I am an embedded
> Linux driver developer, so which one is suit for me?
> 
> Thanks a lot
> Best Regards
> 

The useful developer docs seem to have been lost off the alsa web server.
From: http://www.alsa-project.org/documentation.php3#Driver, there are 
the following broken links:
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
http://www.alsa-project.org/~iwai/alsa-driver-api/index.html

When you build a new alsa driver, you generally have to also create a 
/usr/share/alsa/cards/XXX  file, where XXX is the name of your driver.

The XXX comes from either: -
  strcpy(card->driver, "XXX");  in your probe routine.

I think you will find the most help if you post the unfinished source 
code for your driver, so that people can look at it, and maybe suggest 
corrections for you.

The best way to test your new driver is with a test tool like 
speaker-test or pcm.

With these you can send a tone to the speakers. You can also set the 
sample rate and number of channels, so that it can test the driver, 
without needing to use plug devices initially.
E.g. If your sound card can only do 48khz stereo. Start testing it with:
speaker-test -r48000 -Dhw:0,0 -c2

plug devices tend not to work well until you have a correctly 
functioning driver.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
