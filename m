From: Tim Goetze <tim@quitte.de>
Subject: Re: How to send data trough rawmidi ?
Date: Mon, 8 Apr 2002 20:27:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0204082000180.783-100000@summer.quitte>
References: <20020408092003.01101e29.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020408092003.01101e29.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: Alsa-devel@lists.sourceforge.net, charles.fleche@meletu.univ-valenciennes.fr
List-Id: alsa-devel@alsa-project.org

Maarten de Boer wrote:

>> so essentially you skip alsalib and interact with the driver only. i
>> have found this to be the least painful way of dealing with raw MIDI
>> streams.
>
>Tim, I think this is very bad advice, especially on the alsa-dev
>mailinglist!

i beg to differ. i have always regarded this plain old UNIX way of
accessing MIDI devices as a welcome feature of ALSA, and found it
to be appropriate in most cases.

look, i've been hacking on MIDI sequencing for a few years now, and
the only thing that i have ever wanted from MIDI devices other than
the open/read/write/poll/close suite was to find out what the
outbound bandwidth of an interface is -- and in most cases you can
expect it to be what 31.25kb 8n1 can achieve.

lastly, i would like to add that i feel that alsa-dev is the right
place to pronounce criticism of ALSA, or should there be no place for
that?

tim
