From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to tell user level hardware not support a
 certain format in a certain sample rate
Date: Mon, 16 Mar 2009 09:54:28 +0100
Message-ID: <49BE13C4.10909@ladisch.de>
References: <4e090d470902222302g16a99f5dq77d0d40f6cba855e@mail.gmail.com>	
	<4e090d470903020604h27ce2ce8l47f996edc9764ada@mail.gmail.com>	
	<49AC0232.1060909@ladisch.de>
	<4e090d470903150338q74cd3538xe908bc3d7df9a8de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 67D742436A
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 09:54:27 +0100 (CET)
In-Reply-To: <4e090d470903150338q74cd3538xe908bc3d7df9a8de@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Richard Zhao wrote:
> Sure I can add rules. but the rules will be checked as hw_param. If
> hw_param failed, does alsalib convert fmt or sample rate
> automatically?
> 
> For example:
> One codec, support:
> 44.1k : s8 s16 s24 s32
> 96k:  s24 s32
> 
> When user try to play s8/s16 96k audio file, hw_param will fail.

This is not how the rules work.

Initializing a device works like this:
1) The application opens the device, and the driver's open callback gets
   called.
2) The application chooses hardware parameters; ALSA checks that these
   values conform to the device's limitations.
3) After all hardware parameters are known, the driver's hw_params
   callback gets called.

When you driver adds constraint rules, it has do this in the open
callback (so that the rules are available in step 2 above).  Your
constraint rules will be called when the application tries to select
parameters; this is before the hw_params callback gets called.

In your example above, the open callback would install two rule
functions: one to remove s8/s16 if 96k has been selected, and one to
remove 96k if s8/s16 has been selected.

When the hw_params callback is called, ALSA guarantees that the
parameters are valid for the device.


HTH
Clemens
