From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 09:35:57 +0200
Message-ID: <4E53585D.9050004@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>
	<CACTFLANnEEV8waJvs7Yw4Y_KdD5CmK565+YBWLqZ8tu8qfGO3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy3-pub.bluehost.com (oproxy3-pub.bluehost.com [69.89.21.8])
	by alsa0.perex.cz (Postfix) with SMTP id 93DBF245B3
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 09:36:48 +0200 (CEST)
In-Reply-To: <CACTFLANnEEV8waJvs7Yw4Y_KdD5CmK565+YBWLqZ8tu8qfGO3w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/22/11 13:49, Daniel Mack wrote:
> It doesn't seem to be using a standard MIDI interface, but there's a
> chance that it accepts raw MIDI byte streams. Can you check the patch
> below?

With that patch, the device shows up, but aseqdump does not report any
MIDI events after connecting to it.

The Windows drivers are called "USB Serial Converter" and "USB Serial
Port", so maybe it's all wrapped in a different protocol. Does that name
ring a bell?

-- 
Kristian
