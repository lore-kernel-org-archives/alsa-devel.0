From: Paul Davis <pbd@op.net>
Subject: Re: PCM API questions
Date: Mon, 24 Jun 2002 08:49:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206241248.g5OCm3f17394@post2.fast.net>
References: <s5hr8iw97h0.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 24 Jun 2002 14:39:07 +0200."
             <s5hr8iw97h0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Joshua Haberman <joshua@haberman.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> 2.  How is device selection designed to work with ALSA?  My experience
>> with ALSA has been very confusing in this regard.  I recall reading at
>> least once that ALSA is not designed to have applications enumerate all
>> the devices; that the correct way is to use ~/.asoundrc to define a
>> hardware device and then supply that name to applications.  But is there
>> anything more sophisticated an application can do than to just present
>> the user with a text box?
>
>the pcm name really depends on the driver implementation.
>usually, device #0 is provided for general use.  but, for example, the
>implementation of 4-channel sound is driver speicific.
>some driver implements using a control switch and other combines
>multiple pcm streams, etc.
>
>however, there are standard names, too:
>default, front, rear, center_lfe, surround40, surround51, spdif and
>iec958 (identical with spdif).
>it would be nice if users can choose one of them from a list, and
>additionally have an input text field (well, not sophisticated,
>though).

but there's no straightforward method of determining which names
actually exist. the code in aplay that handles the -L request, for
example, is baroque to the point of extremity. an application could
not just use those standard names, because the audio interface they
have may not support them.

in addition this also doesn't deal with the issue of users with more
than one soundcard installed.

--p


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
