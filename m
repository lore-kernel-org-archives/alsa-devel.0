From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH0/2] jack: Add support for SND_JACK_LINEOUT
Date: Tue, 21 Oct 2008 15:42:19 -0400
Message-ID: <48FE309B.5070003@embeddedalley.com>
References: <48FCFAA8.8070005@embeddedalley.com>
	<20081021084806.GC10841@sirena.org.uk>
	<48FDF318.8050502@embeddedalley.com>
	<20081021193626.GA6900@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 1ED3E243AC
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 21:42:52 +0200 (CEST)
In-Reply-To: <20081021193626.GA6900@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Oct 21, 2008 at 11:19:52AM -0400, Matthew Ranostay wrote:
>> Mark Brown wrote:
> 
>>> or a microphone then there's no need for it - HEADSET is only provided
>>> to make it more obvious how to implement one since people often don't
>>> think of a headset as being its components.
> 
>> Actaully it's for the jack that has a mixer switch, in which the headphone
>> support turned off and becoming a line out. I can understand not adding this,
>> since only one codec patchset will probably use it.
> 
> What do you mean by a "mixer switch"?  Do you just mean a software
> control that can select between line and headphone signals?
Yeah, when it's a line out it doesn't mute the other lineouts.
Is the
> hardware able to determine which kind of device is connected to the
> jack?
> 

Yes with the AC_VERB_GET_PIN_WIDGET_CONTROL verb being read when reporting the
jack status.


-Matt
