From: Forwinder <forward@forwind.net>
Subject: Re: problems with Intel Corporation 82801H (ICH8
	Family)	HD Audio	Controller (rev 03)
Date: Mon, 21 Jan 2008 16:49:00 +0000
Message-ID: <f53DlUKZ.1200934140.0582890.forward@harwood.textdrive.com>
References: <s5h8x2je1pl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailscan1.textdrive.com (mailscan1.textdrive.com
	[207.7.108.214]) by alsa0.perex.cz (Postfix) with ESMTP id 5E9052456D
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 17:49:04 +0100 (CET)
In-Reply-To: <s5h8x2je1pl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi wrote:

>It's a VERY old version.  Try to install the latest ALSA HG version or
>the daily snapshot tarball.  If it still doesn't work, check the codec
>from /proc/asound/card0/codec#* file, and try to pass model option
>values listed in ALSA-Configuration.txt.

I installed 1.0.15 from the website and had to add 'acer-aspire' as an
option inorder to get it to work. With 'acer' as the option the
speakers worked but the headphones didn't but 'acer-aspire' as the
option the speakers and headphones worked but the speakers did not mute
when headphones were plugged into the socket.

now it's working pretty okay.

Thanks for the help,
Conor


On 1/21/2008, "Takashi Iwai" <tiwai@suse.de> wrote:

>At Thu, 17 Jan 2008 23:30:37 +0000,
>forwind wrote:
>>
>> Hi folks,
>>
>> I am having difficulty getting a friends on-board speakers working on
>> her laptop. After some reading of forums I'm not sure whether there is a
>> solution for this or not ?
>>
>> The setup and details can be read below. The headphones work fine but
>> the speakers are mute even though nothing is muted. I installed from
>> source alsa version 1.0.15rc3 but to no avail.
>
>It's a VERY old version.  Try to install the latest ALSA HG version or
>the daily snapshot tarball.  If it still doesn't work, check the codec
>from /proc/asound/card0/codec#* file, and try to pass model option
>values listed in ALSA-Configuration.txt.
>
>
>Takashi
