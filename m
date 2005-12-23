From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Writing a Full-Duplex (capture/playback)	application.
Date: Fri, 23 Dec 2005 10:57:59 +0000
Message-ID: <43ABD837.80601@superbug.co.uk>
References: <1135243534.13713.7.camel@jazc.fedora>	 <43AAE5A4.60902@pianodisc.com> <1135330750.22198.4.camel@jazc.fedora>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1135330750.22198.4.camel@jazc.fedora>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juan Zapatero <jazc@gmvsistemas.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juan Zapatero wrote:
> I've solved the problem concerning encapsulation into wave format,
> thanks to Steve deRosier, but I still have another problem. How can I
> configure hw:0,0 device to capture and play audio in Mono mode (only 1
> channel).
> I've tried to specify 1 channel with
> snd_pcm_hw_params_set_channels(captura, cparams, 1), but I get an
> 'Unable to set channels' error.
> 
> Thanks.
> 

When doing full duplex, do not open the device as full duplex, open the 
device twice. Once for playback and once for capture. The reason for 
this is that sound cards often have different buffer sizes for capture 
and playback, and so separating them gives you more control over buffer 
and period sizes.
For playback use device name "plug:front", for capture you can use the 
same "plug:front". The important bit it the "plug", as it will do sample 
rate and sample format conversion for you.
For low latency application like voice, it is actually better to sample 
at high frequencies, e.g. 48000Hz. You then do the sample rate 
conversion in your application. This way, not only is the sample rate 
conversion much higher quality than alsa-lib can probably do, it can 
also be optimised for your application. e.g. VoIP usually uses 20ms of 
voice per packet. You can create a very efficient block sample rate 
converter when taking all 20ms into account.
There is also an option in the api to force the "plug" layer to do 
sample format conversion, but not sample rate conversion, thus ensuring 
that alsa-lib does not do any sample rate conversion, leaving your 
application to do it.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
