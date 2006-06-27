From: Barry Scott <barry.scott@onelan.co.uk>
Subject: Re: Alsa v1.0.12rc1 Realtek ALC260 PCM missing at boot
Date: Tue, 27 Jun 2006 15:12:46 +0100
Message-ID: <44A13CDE.5060001@onelan.co.uk>
References: <44A11C5D.7010606@onelan.co.uk> <s5h7j32wz3y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7j32wz3y.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 27 Jun 2006 12:54:05 +0100,
> Barry Scott wrote:
>   
>> I'm using 21.6.17.1 with v1.0.12rc1 drivers, libs and utils on FC4.
>> alsamixer reports that the Chip is Realtek ALC260.
>>
>> Both amixer and alsamixer show that the PCM control is missing after 
>> booting.
>> After playing a wav file with aplay the PCM control shows up in both
>> amixer and alsamixer.
>>
>> Is there something I need to configure or is this a bug in1.0.12rc1?
>>     
>
> The PCM volume is added dynamically by alsa-lib softvol plugin.
> Usually your system stores/restores the mixer status so that the PCM
> volume reappears again at the next boot.
>
>
> Takashi
>   
What is it that I need to setup to turn on the PCM? The "system" is me 
and this
is a new setup requirement that I have not seen before.

Barry


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
