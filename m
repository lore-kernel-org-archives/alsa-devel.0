From: Trevor Feeney <trev@feens.org>
Subject: Re: Revo 5.1
Date: Wed, 7 Dec 2005 18:36:41 +0000 (UTC)
Message-ID: <loom.20051207T193631-374@post.gmane.org>
References: <43948A9F.6020009@feens.org> <43948F9E.50407@seznam.cz> <4395A188.7060307@feens.org> <s5hu0dmjn6f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> At Tue, 06 Dec 2005 09:34:48 -0500,
> Trevor Feeney wrote:
> > 
> > Was taking a look at the source for the Revo 5.1, noticed a few things.  
> > You set it up as using only 6 DACs, going by the 5.1 I figure, but when 
> > you consider that it also has the headpone out, it would have the same 
> > number of DACs as the 7.1 (8 DACs in all). 
> > 
> > Takashi - that answers your question in the last thread...from what I've 
> > read, the 5.1 only uses one codec, and the headphones would just be a 
> > separate channel.  I tried adjusting the number of DACs to 8 in the 
> > driver, and did manage to get two
> > DAC mixer sliders.  I'm not really sure if that was the way to go or 
> > not.  I tried adjusting the asound plugin to output to 8 channels, pcm 
> > device surround71, but that didn't seem to work.  I wondering if it 
> > needs to be setup separately thant the other 6 channels so that it would 
> > be considered it's own PCM device.  That goes a bit beyond my realm of 
> > knowledge for driver development though...still trying to learn this.  
> > Been reading a lot of the documents and such.
> 
> [Added alsa-devel ML again]
> 
> In the case of ice1724, you can open a stereo stream separately.
> The first PCM is assigned to the multi-channel, i.e. 2-8 channels
> interleaved format.  The secondary PCM is for SPDIF.  The third PCM is
> the "independent" streams.  This may have up to 3 substreams, each of
> which is a 2-channel one.  If you change num_dacs = 8, you'll be able
> to access plughw:0,2,3 (suppose the card# is 0) for the last two
> channels individually:
> 
> 	% aplay -Dplughw:0,1,3 foo.wav
> 
> And you have to raise the corresponding DAC mixer values, of course.
> 
> Takashi
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> 


I tried the aplay without succes...oh, and I was assuming that it should be 
plughw:0,2,1, plughw:0,2,2, and plughw:0,2,3.  

However, I was doing some looking into the chips used on the card and had a 
thought.  The 5.1 uses the envy24gt as opposed to the envy24ht.  The big 
difference is that the gt is that it is a 6 channel card.  However, with the 
headphones included, there are 8 output channels/DACS in total.  So I would 
guess that basing the card off the ht, setting it up with 8 DACs would not 
work.  Though I'm still figuring this out, I'm guessing that means that one 
output (pcm)_channel actually has to drive 2 DACs.  I'm not quite sure where 
to go with that though.

Any help, suggestions, etc would be welcomed.

Trevor



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
