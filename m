From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: How to send data trough rawmidi ?
Date: Mon, 8 Apr 2002 09:20:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020408092003.01101e29.mdeboer@iua.upf.es>
References: <20020407164211.E1822@pengouin.univ-valenciennes.fr>
	<Pine.LNX.4.21.0204071707250.761-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.21.0204071707250.761-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>, Alsa-devel@lists.sourceforge.net, charles.fleche@meletu.univ-valenciennes.fr
List-Id: alsa-devel@alsa-project.org

> so essentially you skip alsalib and interact with the driver only. i
> have found this to be the least painful way of dealing with raw MIDI
> streams.

Tim, I think this is very bad advice, especially on the alsa-dev
mailinglist!

Charles, you might want to have a look at the documentation:

http://www.alsa-project.org/alsa-doc/alsa-lib/group___raw_midi.html#a6

You can see there that the first argument is for the input handler, and
the second for the output handler. Also, I think you don't want to open
the stream full duplex. Write only would do.

Maarten
