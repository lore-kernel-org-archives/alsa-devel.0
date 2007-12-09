From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH 1/2] sis7019: support the SiS 7019
	Audio	Accelerator
Date: Sun, 09 Dec 2007 13:04:36 -0500
Message-ID: <1197223476.3994.5.camel@obelisk.thedillows.org>
References: <1197158040.3588.51.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id F2A491038C0
	for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2007 19:04:41 +0100 (CET)
Received: from obelisk.thedillows.org (obelisk.thedillows.org [192.168.0.10])
	by shed.thedillows.org (8.13.8/8.13.8) with ESMTP id lB9I4bmm019707
	for <alsa-devel@alsa-project.org>; Sun, 9 Dec 2007 13:04:37 -0500
Received: from obelisk.thedillows.org (localhost.localdomain [127.0.0.1])
	by obelisk.thedillows.org (8.14.1/8.13.8) with ESMTP id lB9I4a49031710
	for <alsa-devel@alsa-project.org>; Sun, 9 Dec 2007 13:04:36 -0500
Received: (from il1@localhost)
	by obelisk.thedillows.org (8.14.1/8.14.1/Submit) id lB9I4ajs031707
	for alsa-devel@alsa-project.org; Sun, 9 Dec 2007 13:04:36 -0500
In-Reply-To: <1197158040.3588.51.camel@obelisk.thedillows.org>
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

On Sat, 2007-12-08 at 18:54 -0500, Dave Dillow wrote:
> Basic audio support for the SiS 7019 Audio Accelerator as found in the
> SiS 55x SoC. There is currently no synth support at the moment, but
> audio playback and capture with two periods per buffer has seen
> extensive use. Arbitrary period and buffer sizes (with multiple periods
> per buffer) have seen light testing, but are believed to be production
> ready.

This isn't ready for prime-time just yet -- while adding surround sound
support, I ran across a bug that shows up in this version which can
cause the playback to go away if the formats of the mixed voices differ.
I'm not sure if it is a SW or HW issue, and the playback loss is
sometimes gone until the module gets reloaded.
