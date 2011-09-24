From: Stas Sergeev <stsp@list.ru>
Subject: Re: [patch][saa7134] do not change mute state for
	capturing audio
Date: Sat, 24 Sep 2011 19:51:12 +0400
Message-ID: <4E7DFC70.3010709@list.ru>
References: <4E19D2F7.6060803@list.ru> <4E25A7C2.3050609@list.ru>
	<4E25C7AE.5020503@infradead.org> <4E25CF35.7000802@list.ru>
	<4E25DB37.8020609@infradead.org> <4E25FDE4.7040805@list.ru>
	<4E262772.9060509@infradead.org> <4E266799.8030706@list.ru>
	<4E26AEC0.5000405@infradead.org> <4E26B1E7.2080107@list.ru>
	<4E26B29B.4010109@infradead.org> <4E292BED.60108@list.ru>
	<4E296D00.9040608@infradead.org> <4E296F6C.9080107@list.ru>
	<4E2971D4.1060109@infradead.org> <4E29738F.7040605@list.ru>
	<4E297505.7090307@infradead.org> <4E29E02A.1020402@list.ru>
	<4E2A23C7.3040209@infradead.org> <4E2A7BF0.8080606@list.ru>
	<4E2AC742.8020407@infradead.org> <4E2ACAAD.4050602@list.ru>
	<4E2AE40F.7030108@infradead.org> <4E2C5A35.9030404@list.ru>
	<4E2C6638.2040707@infrade ad.org> <4E760BCA.6080900@list.ru>
	<4E7DB798.4060201@infradead.org> <4E7DBB1C.1090407@list.ru>
	<4E7DC93C.9080101@infradead.org> <4E7DCEC1.6010405@list.ru>
	<4E7DD1A5.5080204@infradead.org> <4E7DD92A.8030300@list.ru>
	<4E7DF2AA.4010104@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp14.mail.ru (smtp14.mail.ru [94.100.176.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 537E11037FC
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Sep 2011 17:51:51 +0200 (CEST)
In-Reply-To: <4E7DF2AA.4010104@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>, Lennart Poettering <lpoetter@redhat.com>, ALSA devel <alsa-devel@alsa-project.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

24.09.2011 19:09, Mauro Carvalho Chehab wrote:
>>> If someone is using the board on an environment
>>> without udev and pulseaudio, this trick will break the first tuning.
>> I feel this somehow contradicts with your suggestion
>> to remove the first scan, so could you clarify?
> What I meant to say is that both udev and pulseaudio opens the device,
> and these might initialize the audio thread. The driver should be able
> to work the same way with or without the first open by udev/pulseaudio.
But the first scan I was referring to, and am going
to remove, happens not on the device open, but on
the driver init (modprobe time).
open()s are safe, fortunately.
> The autounmute is not a hack. It is a logic to suppress audio when the
> audio carrier is not detected. It should not be removed.
You are confusing the automute and autoUNmute.
Autounmute is a must-die hack, and we only need
to fix mplayer first. Automute just needs a fix.
Though I'd personally remove the automute too, by
exporting some interface for an app to query the
signal strength... but that's another story. :)

> I'm not sure if it is safe to make mplayer to use the audio mixer.
Why, if otherwise it already uses alsa in our case?
The mixer control is just another part of an alsa
interface, and it is already exported to the v4l apps, so...

>   It
> is probably a good idea doing that, as it will also work fine with webcams
> that provide alsa inputs.
And will make pulseaudio happy, that's for sure. :)
