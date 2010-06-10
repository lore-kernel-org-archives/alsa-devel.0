From: Josh Lehan <alsa@krellan.com>
Subject: Re: New release of amidicat program,
 connecting MIDI to stdin/out
Date: Thu, 10 Jun 2010 00:14:47 -0700
Message-ID: <4C1090E7.9050602@krellan.com>
References: <4C0DF2A8.8000305@krellan.com>
	<20100608080251.GD2695@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server3.hostdango.com (server3.hostdango.com [67.222.146.219])
	by alsa0.perex.cz (Postfix) with ESMTP id B468310397F
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jun 2010 09:14:53 +0200 (CEST)
In-Reply-To: <20100608080251.GD2695@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Josh Lehan <alsa@krellan.com>
List-Id: alsa-devel@alsa-project.org

On 06/08/2010 01:02 AM, Daniel Mack wrote:
> On Tue, Jun 08, 2010 at 12:35:04AM -0700, Josh Lehan wrote:
>> Hello.  On the mailing list a few months ago, mentioned a program I had
>> written, then called "midicat".  Found out there's another product by
>> that name.  So, the new name of the program is "amidicat".  The "a"
>> prefix also clarifies that it's an ALSA program.
>>
>> It's a program that connects the ALSA MIDI sequencer to standard input
>> and output.  Among other things, this is fun for prototyping quick MIDI
>> one-liners on the command line, such as "echo 903C7F | amidicat" to play
>> Middle C.
>>
>> I have made a new release of the program, which is basically unchanged,
>> except for a few bug fixes (thanks to Valgrind for discovering a minor
>> memory leak).  The biggest improvement is that there's now a manual page
>> and a DocBook documentation page.
>>
>> Here's the webpage for amidicat, if interested:
>>
>> http://www.krellan.com/amidicat/
> 
> Again, thanks. Any chance that any Debian maintainer reading this can
> take care for bringing this useful tool to the repositories?
> 
> Daniel

You're welcome!

On the mailing list a while ago, Takashi Iwai mentioned it would be nice
to have in alsa-utils.

That would be a great place for it, and it would fit in well with the
other "a" tools there.

Then, all repositories would get it, not just Debian :)

Josh Lehan
