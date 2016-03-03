From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v3 03/22] [media] Docbook: media-types.xml: Add Audio
 Function Entities
Date: Thu, 3 Mar 2016 15:50:19 -0700
Message-ID: <56D8BFAB.7010509@osg.samsung.com>
References: <cover.1455233150.git.shuahkh@osg.samsung.com>
 <f591af59b7b1c77b5a17603a1a677a32b8e19132.1455233153.git.shuahkh@osg.samsung.com>
 <1886674.Y0SDWvK9bd@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1886674.Y0SDWvK9bd@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: mchehab@osg.samsung.com, tiwai@suse.com, clemens@ladisch.de, hans.verkuil@cisco.com, sakari.ailus@linux.intel.com, javier@osg.samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, arnd@arndb.de, dan.carpenter@oracle.com, tvboxspy@gmail.com, crope@iki.fi, ruchandani.tina@gmail.com, corbet@lwn.net, chehabrafael@gmail.com, k.kozlowski@samsung.com, stefanr@s5r6.in-berlin.de, inki.dae@samsung.com, jh1009.sung@samsung.com, elfring@users.sourceforge.net, prabhakar.csengg@gmail.com, sw0312.kim@samsung.com, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, pierre-louis.bossart@linux.intel.com, ricard.wanderlof@axis.com, julian@jusst.de, takamichiho@gmail.com, dominic.sacre@gmx.de, misterpib@gmail.com, daniel@zonque.org, gtmkramer@xs4all.nl, normalperson@yhbt.net, joe@oampo.co.uk, linuxbugs@vittgam.netjo
List-Id: alsa-devel@alsa-project.org

On 02/28/2016 07:46 PM, Laurent Pinchart wrote:
> Hi Shuah,
> 
> Thank you for the patch.
> 
> On Thursday 11 February 2016 16:41:19 Shuah Khan wrote:
>> Add Audio Function Entities
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  Documentation/DocBook/media/v4l/media-types.xml | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/DocBook/media/v4l/media-types.xml
>> b/Documentation/DocBook/media/v4l/media-types.xml index 3730967..924a604
>> 100644
>> --- a/Documentation/DocBook/media/v4l/media-types.xml
>> +++ b/Documentation/DocBook/media/v4l/media-types.xml
>> @@ -113,6 +113,18 @@
>>  		   decoder.
>>  	    </entry>
>>  	  </row>
>> +	  <row>
>> +	    <entry><constant>MEDIA_ENT_F_AUDIO_CAPTURE</constant></entry>
>> +	    <entry>Audio Capture Function Entity.</entry>
>> +	  </row>
>> +	  <row>
>> +	    <entry><constant>MEDIA_ENT_F_AUDIO_PLAYBACK</constant></entry>
>> +	    <entry>Audio Playback Function Entity.</entry>
>> +	  </row>
> 
> I think this deserves a longer description. From the name and short 
> description I'm not sure what the capture and playback functions are.
> 
>> +	  <row>
>> +	    <entry><constant>MEDIA_ENT_F_AUDIO_MIXER</constant></entry>
>> +	    <entry>Audio Mixer Function Entity.</entry>
>> +	  </row>
> 
> Entities can implement multiple functions, so function descriptions shouldn't 
> refer to entity this way. MEDIA_ENT_F_AUDIO_MIXER doesn't mean that the entity 
> is an audio mixer, it means that the entity implements the audio mixer 
> function. If you want to keep the description short you could just write 
> "Audio mixer". A longer description could be "The entity can mix multiple 
> input audio streams to produce an output audio stream.".
> 
>>  	</tbody>
>>        </tgroup>
>>      </table>
> 

Thanks for the review. I will send a followup patch
for this.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
