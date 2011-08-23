From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 15:28:04 +0200
Message-ID: <4E53AAE4.2070303@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>	<4E53959A.7090702@amlie.name>	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>	<4E53A748.4070404@amlie.name>
	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy1-pub.bluehost.com (oproxy1-pub.bluehost.com
	[66.147.249.253])
	by alsa0.perex.cz (Postfix) with SMTP id ED30F103A0F
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 15:28:23 +0200 (CEST)
In-Reply-To: <CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 08/23/11 15:16, Daniel Mack wrote:
> On Tue, Aug 23, 2011 at 3:12 PM, Kristian Amlie <kristian@amlie.name> wrote:
>> Here is the output from one complete run of cu, including connecting,
>> pressing a key once on the instrument and killing cu afterwards:
> ...
> And now once again without killing cu, please. I'm interested in the
> last commands that occur before the device starts working.

Here you go:

[21535.096008] change_speed(): urb_value: 16696, urb_index: 0
[21535.097918] update_mctrl(): urb_value: 771, priv->interface: 0
[21535.099917] change_speed(): urb_value: 49230, urb_index: 0
[21535.103055] change_speed(): urb_value: 49230, urb_index: 0
[21535.106037] change_speed(): urb_value: 49230, urb_index: 0

-- 
Kristian
