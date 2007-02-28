From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Quality resampling code for libasound
Date: Wed, 28 Feb 2007 13:10:45 +1100
Message-ID: <45E4E4A5.6020405@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>	<s5hodnm7774.wl%tiwai@suse.de>	<45DD8329.6080809@usherbrooke.ca>
	<s5hlkiq75up.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040308010106050709040102"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlkiq75up.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040308010106050709040102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> Yes.  I'll apply your current version to the HG tree now, then.

Thanks. Now, what are the requirements to have it enabled as the default
resampler?

>> What kind of document do you want? I can't find anything about the other
>> sample rate converters, so I'm not sure what it should look like.
> 
> A brief instruction how to set up would be enough.
> See alsa-plugins/doc/samplerate.txt, for example.
>
> Although it's planned to be merged in future, a documentation is
> always nice to have :)
>

OK, did a bit of search/replace on samplerate.txt and attached the
result. As you can see, it's fairly similar. So far, I'm also including
3 levels of quality that match the libsamplerate levels, but I can
change that depending on what people want. The Speex resampler offers
quality settings that range from 0 to 10, so I can expose them all (is
there a way to pass a quality parameter to the resampler instead of
having to create lots of symbolic links?).

	Jean-Marc

--------------040308010106050709040102
Content-Type: text/plain;
 name="speexrate.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="speexrate.txt"

Rate Converter Plugin Using Libsamplerate
=========================================

The plugin in rate subdirectory is an external rate converter using
the Speex resampler (aka Public Parrot Hack) by Jean-Marc Valin.  You can 
use this rate converter plugin by defining a rate PCM with "converter" 
parameter, such as:

	pcm.my_rate {
		type rate
		slave.pcm "hw"
		converter "speexrate"
	}

The plug plugin has also a similar field, "rate_converter".

Or, more easily, define a global variable "defaults.pcm.rate_converter",
which is used as the default converter type by plug and rate plugins:

	defaults.pcm.rate_converter "speexrate"

Write the above in your ~/.asoundrc or /etc/asound.conf.

The following converter types are available:

  - speexrate_best	Use quality 10 (equivalent to SRC_SINC_BEST_QUALITY)
  - speexrate_medium	Use quality 5 (equivalent to SRC_SINC_MEDIUM_QUALITY)
  - speexrate		Use quality 3 (equivalent to SRC_SINC_FASTEST)


--------------040308010106050709040102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------040308010106050709040102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------040308010106050709040102--
