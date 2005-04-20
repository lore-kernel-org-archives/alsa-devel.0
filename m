From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: auto capture feature according to sound amplitude?
Date: Wed, 20 Apr 2005 10:11:15 -0700
Message-ID: <42668D33.1050403@pianodisc.com>
References: <d8c9df6c050415095914e35449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <d8c9df6c050415095914e35449@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "IDOIT .IEF" <idoit.ief@gmail.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Your best bet would be to continually capture from alsa, and analyse the samples as they come in.  You could set an amplitude threshold or do some other fancier trigger point (must be between certain frequencies with a certian amplitude, etc...) and just bit-bin the samples to that trigger.  At the trigger, you could then analyse it with your recognition algoritim, and when it's done go back to your wait-on-trigger state.

- Steve

IDOIT .IEF wrote:
> Hi All
> I'm working on a small voice recognition project and i want a library
> or some APIs automates capturing process so it'll start capturing only
> if there is a voice and it'll stay waiting unless
> I'm new to Alsa .. or you can say i'm new to audio programming .. i
> don't know if ALSA has such a feature .. or any other library
> i thought about implementing this feature by my self .. but i don't
> think i have time to do it
> Thanks in Advance
> IDOIT
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
