From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 03/22] [media] Docbook: media-types.xml:
	Add Audio Function Entities
Date: Mon, 29 Feb 2016 04:46:05 +0200
Message-ID: <1886674.Y0SDWvK9bd@avalon>
References: <cover.1455233150.git.shuahkh@osg.samsung.com>
 <f591af59b7b1c77b5a17603a1a677a32b8e19132.1455233153.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from galahad.ideasonboard.com (galahad.ideasonboard.com
 [185.26.127.97])
 by alsa0.perex.cz (Postfix) with ESMTP id C44DB260564
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 03:45:57 +0100 (CET)
In-Reply-To: <f591af59b7b1c77b5a17603a1a677a32b8e19132.1455233153.git.shuahkh@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: klock.android@gmail.com, k.kozlowski@samsung.com, clemens@ladisch.de, alsa-devel@alsa-project.org, ruchandani.tina@gmail.com, prabhakar.csengg@gmail.com, normalperson@yhbt.net, bert@huitsing.nl, ricardo.ribalda@gmail.com, elfring@users.sourceforge.net, m.szyprowski@samsung.com, pierre-louis.bossart@linux.intel.com, pawel@osciak.com, corbet@lwn.net, misterpib@gmail.com, chehabrafael@gmail.com, al@alsa-project.org, javier@osg.samsung.com, crope@iki.fi, hans.verkuil@cisco.com, linuxbugs@vittgam.net, takamichiho@gmail.com, jh1009.sung@samsung.com, dan.carpenter@oracle.com, linux-media@vger.kernel.org, julian@jusst.de, ricard.wanderlof@axis.com, p.zabel@pengutronix.de, arnd@arndb.de, mchehab@osg.samsung.com, tvboxspy@gmail.com, linux-kernel@vger.kernel.org, inki.dae@samsung.com, geliangtang@163.com, nenggun.kim@samsung.com, joe@oampo.co.uk, dominic.sacre@gmx.de, j.anaszewski@
List-Id: alsa-devel@alsa-project.org

Hi Shuah,

Thank you for the patch.

On Thursday 11 February 2016 16:41:19 Shuah Khan wrote:
> Add Audio Function Entities
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  Documentation/DocBook/media/v4l/media-types.xml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/DocBook/media/v4l/media-types.xml
> b/Documentation/DocBook/media/v4l/media-types.xml index 3730967..924a604
> 100644
> --- a/Documentation/DocBook/media/v4l/media-types.xml
> +++ b/Documentation/DocBook/media/v4l/media-types.xml
> @@ -113,6 +113,18 @@
>  		   decoder.
>  	    </entry>
>  	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_ENT_F_AUDIO_CAPTURE</constant></entry>
> +	    <entry>Audio Capture Function Entity.</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_ENT_F_AUDIO_PLAYBACK</constant></entry>
> +	    <entry>Audio Playback Function Entity.</entry>
> +	  </row>

I think this deserves a longer description. From the name and short 
description I'm not sure what the capture and playback functions are.

> +	  <row>
> +	    <entry><constant>MEDIA_ENT_F_AUDIO_MIXER</constant></entry>
> +	    <entry>Audio Mixer Function Entity.</entry>
> +	  </row>

Entities can implement multiple functions, so function descriptions shouldn't 
refer to entity this way. MEDIA_ENT_F_AUDIO_MIXER doesn't mean that the entity 
is an audio mixer, it means that the entity implements the audio mixer 
function. If you want to keep the description short you could just write 
"Audio mixer". A longer description could be "The entity can mix multiple 
input audio streams to produce an output audio stream.".

>  	</tbody>
>        </tgroup>
>      </table>

-- 
Regards,

Laurent Pinchart
