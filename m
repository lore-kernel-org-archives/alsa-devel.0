From: Singaravelan Nallasellan <singaravelann@hotmail.com>
Subject: Targeting a stream with a the device
Date: Fri, 21 Aug 2009 12:29:16 +0000
Message-ID: <BAY119-W211FD3BCC6CBEC2C94CEC3B0FC0@phx.gbl>
References: <c697747b0908210037g341b0a52mdff52c955d5814a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s6.bay0.hotmail.com (bay0-omc2-s6.bay0.hotmail.com
	[65.54.246.142]) by alsa0.perex.cz (Postfix) with ESMTP id 91738245BF
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 14:29:22 +0200 (CEST)
In-Reply-To: <c697747b0908210037g341b0a52mdff52c955d5814a1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

 =


I write a sound card driver which supports multiple streams and each stream=
 should go to a specific device. I have written the driver to accept multip=
le playback streams and an application to create multiple playback streams =
as well.

 =


Now, I am not able to find a way to send the device type to the driver from=
 my application. I want to attach the device type to the stream. Could anyb=
ody help me?

 =


I am thinking of using sysfs entries for send and receive the stream specif=
ic information? Is it acceptable to ALSA community?

 =


Thanks

Sing =


_________________________________________________________________
Windows Live: Make it easier for your friends to see what you=92re up to on=
 Facebook.
http://windowslive.com/Campaign/SocialNetworking?ocid=3DPID23285::T:WLMTAGL=
:ON:WL:en-US:SI_SB_facebook:082009
