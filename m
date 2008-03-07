From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: ALSACTL wrong restore on ARM9
Date: Fri, 7 Mar 2008 16:28:20 +0100
Message-ID: <41682.3271931664$1204903758@news.gmane.org>
References: <002201c88065$972cb180$c5861480$@bouin@kerlink.fr>
	<1204903153.6429.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id BADC024384
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 16:28:22 +0100 (CET)
In-Reply-To: <1204903153.6429.38.camel@localhost.localdomain>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Liam Girdwood' <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Can you describe 'bad values' in a little more detail.

You're right, some details are missing.

For example, for first control, a playback volume control, value can go from
0 to 63.
Before "store" command, I'd set it to 20.
I've check that in "/var/lib/alsa/asound/state", I had the same value. Here
is a part of this file : 

state.codec {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 63'
                iface MIXER
                name 'HP Playback Volume'
                value.0 20
                value.1 20
        }

So saved value seems ok.

After "restore" command, I get this :

$amixer cget numid=1
numid=1,iface=MIXER,name='HP Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=63,step=0
  : values=45,45

That's why I say that values are not correct.
I'm currently using debian alsa-utils_1.0.16-1_arm package.
