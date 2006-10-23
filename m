From: Dimitri Van Landuyt <dimitri.vanlanduyt@gmail.com>
Subject: Re: hda-intel on msi megabook
Date: Mon, 23 Oct 2006 16:11:20 +0200
Message-ID: <ehiii7$i2e$1@sea.gmane.org>
References: <ehhqu3$mhi$1@sea.gmane.org> <s5hac3n17ly.wl%tiwai@suse.de>
Reply-To: dimitri.vanlanduyt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hac3n17ly.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 23 Oct 2006 09:28:03 +0200,
> Dimitri Van Landuyt wrote:

>> The sound used to work through my speakers, but recently it stopped 
>> working and now and then it crackles, which I expect to be a result of a 
>> not correctly supported card. It still works fine through headphones and 
>> microphones and everything else works fine.
> 
> How recent?  Which version of ALSA drivers are you using?
> 
> In HG version, there are new model options for ALC883 (see
> ALSA-Configuration.txt), and one of them may match with your device.

ubuntu edgy runs version 1.0.11...


> However...
> 
>> 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
>>           Subsystem: ATI Technologies Inc Unknown device 437b
> 
> This looks scary.  The BIOS doesn't set up the PCI SSID properly...
I'm scared too ;-)
In the taiwanese version of this notebook there is already a BIOS 
upgrade with the following changes:
3. Changed ALC883's codec table for the sound issue of Vista.

I have the american version and this upgrade is not ready yet for my 
notebook. You think this is a relevant update and I should wait for this 
one?

Dimitri


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
