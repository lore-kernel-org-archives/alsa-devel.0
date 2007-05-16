From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Steinberg Midex 8 driver development
Date: Wed, 16 May 2007 09:17:24 +0200
Message-ID: <1179299844.4902.1190076781@webmail.messagingengine.com>
References: <20070515093557.311300@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A3F1124131
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2007 09:17:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070515093557.311300@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Norman Schleicher <NormanSchleicher@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Norman Schleicher wrote:
> I am currently on development for the Steinberg Midex8 USB driver.
> 
> At the moment I can send notes to my Midi equipment via this device.
> Receiving is currently not implemented.
> 
> My questions are:
> 1. Are there any tools to test the Alsa-Midi compatiblity ?

You can send raw MIDI data with amidi, or play entire .mid files with
aplaymidi.

To see received data, use amidi or aseqdump.

> 2. May I release some milestone results to the Alsa project ?

Just publish them somewhere.

> 3. What are the requirements to get released in an official alsa release
> package ?

Post the patches against the latest Hg tree here.

> 4. Where can I read how the source code is organized in the repository

The alsa-kernel tree contains an almost exact copy of the sound/
directory in the Linux kernel tree.

The alsa-driver tree contains the build mechanism for the separate
alsa-driver package, patches and compatibility code to make the code
in alsa-kernel work with older kernels, and some drivers that are too
new or too horrible to allow them into the kernel.

> and how to manage tags and branches for the development ?

https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=SourceCodeRepository
and see the Hg docs.


HTH
Clemens
