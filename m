From: Mark Knecht <markknecht@comcast.net>
Subject: FORWARD - RME Hammerfall HDSP 9652
Date: Mon, 15 Sep 2003 05:22:32 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063628552.1635.1.camel@Wizard.knechthome.com>
References: <3F6499D5.1080306@notam02.no>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F6499D5.1080306@notam02.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
Cc: natasha.barrett@notam02.no
List-Id: alsa-devel@alsa-project.org

Natasha is having email server problems and asked me to forward this to
the list.

- Mark

On Sun, 2003-09-14 at 09:39, Natasha Barrett wrote:
> For some time I have been trying to get the HDSP 9652 sound card
> working under LINUX (with Pd).
> Everything was fine in an old, slower machine. The new machine has
> been impossible, and no-one appears to have had the same problems
> as me. The closest I found was the thread from August about
> firmware revisions. Maybe you can suggest something.
> 
> I currently have rev. 100 of the firmware. Have you tried this?
> 
> Here is a list of alsa & kernel versions tested and the errors they give:
> 
> 1. kernel 2.4.21-1.ll-acpi
> 2. Alsa v 0.9.6
> 
> Result: works OK for anything between 10 minutes to 10 hours and then
> audio stops with input and output values equal levels. No error
> message is given. Audio just stops. The machine may need rebooting 10
> times before audio will resume. It appears random.
> 
> 1. kernel 2.4.21-1.ll-acpi
> 2. Alsa v 0.9.0rc6 (version that worked fine on old machine, can't run 
> old kernel on new machine).
> 
> Result: modprobe snd-hdsp seg faults.
> 
> Have also tried alsa versions:
> 0.9.4 -> made no sound at all.
> 0.9.5 -> Made sound, but only at channel 3-7
> 
> Is it worth trying to upgrade to firmare 101? Is there anyway
> to do this under LINUX, or do I have to install Windows?
> 
> Thanks for any suggestions.
> Natasha Barrett
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
