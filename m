From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add capture source
	selection and mic gain control
Date: Tue, 2 Dec 2008 12:43:37 +0200
Message-ID: <200812021243.38021.peter.ujfalusi@nokia.com>
References: <1228172848-5221-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id AAD71245A7
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 11:43:48 +0100 (CET)
In-Reply-To: <1228172848-5221-1-git-send-email-notasas@gmail.com>
Content-Disposition: inline
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
Cc: ext Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On Tuesday 02 December 2008 01:07:28 ext Grazvydas Ignotas wrote:
> The TWL4030 codec device has two ADCs. Both of them can have
> several inputs routed to them, but TRM says that only one source
> can be selected for every ADC, even though every source has a
> dedicated bit in the registers.
>
> This patch adds controls for capture source controls. When a microphone
> is selected, handlers automatically enable bias power (disable when
> deselected). The patch also adds microphone gain control. Microphone
> and line input recording tested on OMAP3 pandora board.
>

Do you have plans for the Digital microphones (DIGIMIC0, DIGIMIC1)?
Since they are not connected to any of the ADCs, but have separate digital =

path towards the main CPU...
One can use either Analog mic or the Digital mic for TX1 and TX2 (ADCMICSEL =

register).

-- =

P=E9ter
