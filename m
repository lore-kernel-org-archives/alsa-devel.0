From: Andy Robinson <ajr55555@gmail.com>
Subject: Re: CX20585 - selecting wrong digital output
Date: Mon, 10 Jan 2011 12:56:56 -0500
Message-ID: <AANLkTi=8AJ5WGkMKgAaWM03Q-rVwAGQ6N52CTrrA0uZo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B1880244C2
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 18:56:57 +0100 (CET)
Received: by gyg8 with SMTP id 8so8261927gyg.38
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 09:56:56 -0800 (PST)
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

Answering my own question on the wrong digital output being used on
the CX20585 (hda/patch_conexant.c)...

Some of the the other HDA codec patches (patch_analog.c,
patch_cirrus.c) use the first digital output node as the primary
digital out, and set the additional digital outputs as slaves in
codec->slave_dig_outs. Similar logic should probably be put in the
patch_conexant.c as well, at least for the CX20585, to handle the
multiple digital outputs.
