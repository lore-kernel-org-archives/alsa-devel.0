From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smix plugin available?
Date: Mon, 25 Nov 2002 23:13:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18GX3A-0002d8-00@sc8-sf-list1.sourceforge.net>
References: <200211252254.46712.mark@WebServiceSolutions.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 25 Nov 2002 22:54:46 EST."
             <200211252254.46712.mark@WebServiceSolutions.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Swanson <mark@WebServiceSolutions.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> You see, if all apps are written to use the ALSA API, that's going to
>> be great for the purposes you have in mind, but totally awful for
>> those of us who want our audio apps to work in a sample synchronous
>> way and ignorant of the ultimate routing of their data. Many of us
>> don't think that an API based on the open/close/read/write paradigm is
>> appropriate for real time streaming media.
>
>If there was a way to temporarily disable the smix plugin, or temporarily gain
>exclusive ownership of the sound device for your purposes would that meet 
>100% of your requirements?

no, it wouldn't meet any of them. the problem is not exclusive
access. its the fundamental API model. ALSA (like OSS before it, as
well as SGI's DMedia APIs) has promoted the open/close/read/write
model. this is the central problem. ALSA certainly *allows* for a
callback model (its what allows JACK to work), but there are almost no
applications that use ALSA in this way. using the o/c/r/w paradigm
makes sample synchronous execution of multiple applications basically
impossible, and more importantly it encourages application designers
to construct programs based on the idea that the program controls when
to read/write audio data. this doesn't work properly except for
heavily buffered, single applications. the APIs that are used to write
almost all audio software code in production these days all use a
callback model. porting from the o/c/r/w model to the callback one is
hard. do you want another generation of apps stuck with this problem?

if you want a genuinely portable solution, use PortAudio. it works
with (but hides) OSS, Windows MME, ASIO, CoreAudio, and several
others. JACK and ALSA support is present in CVS. it encourages a
callback model.

>> All that being said, I'd love to see the smix plugin implemented and
>> available, if only because it would allow ALSA native apps to
>> participate in a JACK system, albeit without sample synchronous
>> behaviour.
>
>Great.
>Know where to find it? :-)

i think abramo posted a copy of what he had to this list within the
last 5 weeks. unfortunately, sf.net's archives don't allow searching,
so finding it might be tedious, to put it mildly.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
