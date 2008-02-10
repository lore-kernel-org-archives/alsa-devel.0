From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: support for jackSense feature in modern sound	cards
Date: Sun, 10 Feb 2008 11:59:49 -0800
Message-ID: <1202673589.15973.37.camel@razman.gruemaster.com>
References: <200802110103.37082.balajirrao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AB75243B4
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2008 20:59:51 +0100 (CET)
In-Reply-To: <200802110103.37082.balajirrao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Balaji Rao <balajirrao@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Actually, most of the hda_intel sound codecs support jack sense to a
certain extent.  They are mainly used to mute/unmute speaker and
microphone channels when headphones or external microphones are plugged
in.  Some of the codecs support additional sensing to determine the type
of device plugged in, but that is very limited in the drivers, mainly
because of the diverse nature of the systems that these codecs are used
in.

Tobin

On Mon, 2008-02-11 at 01:03 +0530, Balaji Rao wrote:

> Hello people,
> 
> How well is the jack sense feature in modern soundcards supported in the 
> kernel ? I opened up a few driver sources like hda-intel and found the 
> word 'jack sense' in some files, but i could not find it being used anywhere.
> 
> Are there standard interfaces in kmix or equivalent software that use the jack 
> sense feature ? If not, wouldn't it be nice to have a standard interface to 
> expose this feature so that kmix and others could make use of in a device 
> independent way ?
> 
> If yes, I would be more than willing to contribute to its development.
> 
> Please clarify.
> 

-- 
Tobin Davis 


I hate users
 you sound like a sysadmin already!
