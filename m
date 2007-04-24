From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Buffer Overrun Messages
Date: Tue, 24 Apr 2007 09:05:39 +0200
Message-ID: <1177398339.1092.1186220335@webmail.messagingengine.com>
References: <20267daccbbad88e814c591cac550e5b@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id A7567248E1
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 09:05:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20267daccbbad88e814c591cac550e5b@optonline.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Dey <jsdey@optonline.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Dey wrote:
> I have been driving fluidsynth with with aplaymidi and get the 
> following:  fluidsynth: ALSAsequencer buffer overrun, lost event.

This happens when more MIDI events are sent to fluidsynth at the same
time than it can handle.

Does this happen with some specific .mid file?


Regards,
Clemens
