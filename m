From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: Re: [Alsa-devel]JACK will block audio application and
 audio application will also blcok JACK
Date: Mon, 18 Apr 2011 11:19:39 -0300
Message-ID: <BANLkTi=02HqRq9=ewWQ-JNtnxSt9N-DhRQ@mail.gmail.com>
References: <BANLkTi=u9OvWJkPXbxhg5tj_O9Mti9Jeew@mail.gmail.com>
	<BANLkTikSZMqJeRJ5EHZZShvskV-ccx08rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 53CA910384C
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 16:19:43 +0200 (CEST)
Received: by pvf33 with SMTP id 33so2825256pvf.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2011 07:19:40 -0700 (PDT)
In-Reply-To: <BANLkTikSZMqJeRJ5EHZZShvskV-ccx08rw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: cong fu <fc4976@gmail.com>
List-Id: alsa-devel@alsa-project.org

(i forgot the list)

Hi Cong, that is the expected behaviour of Jack.

On 18/04/2011, cong fu <fc4976@gmail.com> wrote:
[...]
> sudo /usr/bin/jackd -r -m -dalsa -dhw:0 -r44100 -p1024 -n2 -P

I'm pretty sure you don't need to run it with root prileges. Add
something like this to /etc/security/limits.conf :

@audio - rtprio 99
#@audio - memlock 5000000
@audio - nice -10
@audio   -  memlock    378909

If your user is not member of the 'audio' group add yourself, logout
and login for changes to take effect.

> So how can I play sound with JACK started?

Tell your application to use jack for output. With mplayer for example
add '-ao jack'. There's also an alsa plugin, see this:

http://alsa-project.org/main/index.php/Asoundrc#JACK_plugin



--
Adrian.
http://ovejafm.com
http://elesquinazotango.com.ar
