From: Clemens Ladisch <cladisch@fastmail.net>
Subject: Re: Specs available for Sweex External 5.1 with
 digital in/out USB 2.0 / C-Media CM6207
Date: Thu, 05 Jun 2008 12:27:46 +0200
Message-ID: <4847BFA2.70202@fastmail.net>
References: <4845A420.10804@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0B37824604
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 12:27:56 +0200 (CEST)
In-Reply-To: <4845A420.10804@slagter.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Erik Slagter <erik@slagter.name>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Erik Slagter wrote:
> These are the actual issues (so far, I didn't yet test it exhaustively):
>
>   - using 2 channel output the sound is garbled; it looks like the
> "wrong" 2 channel alt setting is used (output of
> /proc/asound/card?/stream0 on request), 4/6 channel output is OK though.
>   - some high squeeking noise although C-Media claims the IC to be
> high-end (or maybe their definition of high-end differs from mine ;-))
>   - all outputs are labelled "speaker 1"
>   - only two outputs have a mute knob, the others cannot be silenced in
> any way, only turned down
>   - one of the two outputs with the mute knob doesn't appear to do
> anything (or maybe it's the sp/dif output?)
>   - the other (with mute) controls the front output
>   - the others (without mute) don't seem to do anything at all

Please show the output of "lsusb -v" for this device.


Regards,
Clemens
