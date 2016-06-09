From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Machine Driver Interaction with Codec Drivers
Date: Thu, 9 Jun 2016 12:31:12 +0200
Message-ID: <57594570.7020100@metafoo.de>
References: <0BE0E679-A120-4330-8291-315750457145@xenotropic.com>
 <57586E79.4010309@metafoo.de> <s5hinxihetz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 606232608B3
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 12:31:15 +0200 (CEST)
In-Reply-To: <s5hinxihetz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeremy McDermond <mcdermj@xenotropic.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/09/2016 11:49 AM, Takashi Iwai wrote:
> On Wed, 08 Jun 2016 21:14:01 +0200,
> Lars-Peter Clausen wrote:
>>
>> Hi,
>>
>> No this is currently not really supported. There were some ideas for this a
>> long long time ago, but it never got implemented. And today basically
>> everybody takes care of hiding the controls from userspace.
>>
>> That does not mean it does not make sense to have such a feature, but it
>> needs somebody with a motivation to implement it.
> 
> The devils live in details.  Actually a primary question is in which
> level we should cover it.  For example, can we disable DAPM pins from
> the machine driver?  This will reduce not only kctls but DAPM paths.
> Or should we mark kctls just as invisible?  Or, would it be suitable
> rather to hide such a thing in user-space?

For DAPM we already do this. Even automatically the DAPM core is capable of
figuring out which paths are unused and will never be powered-up. The path
will still exist in the graph but it will be ignored for all operations and
not significantly affect performance.

And I think the idea back then was to track which controls are on which
paths and if it is on a non-connected path disable the control. What's a bit
tricky is if you have a mixer or mux and only some of the output/input paths
are not connected. Also for most controls we do not have the information
where they are placed within the graph.
