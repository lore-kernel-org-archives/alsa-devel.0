From: "Pavana Sharma" <pavans@india.ti.com>
Subject: help needed-- providing control interface
Date: Fri, 26 Mar 2004 16:23:09 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <015001c41320$878d92a0$f8b6a8c0@ent.ti.com>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

hello,

I am providing control interface for my driver to access from user space
with functions get & put .
 ( driver is for arm platform ) .

I want to know

 * while creating new controls should I be allowed to create my hardware
specific controls like gain, power, rate & other codec specific parameters.
	or  should I take care of mapping OSS mixer controls to ALSA mixer.
 * How user comes to know what controls are available & the valid range of
values for sliders & switches.
As I'm new to ALSA, can anyone explain me in detail, in this ragard.
Thanks & Regards
Pavana S



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
