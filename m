From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecordmidi and aplaymidi
Date: Wed, 17 Nov 2004 09:05:03 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411170845150.16382-200000@studcom.urz.uni-halle.de>
References: <200411160838.31853.wackysalut@bourget.cc>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2015913978-758783491-1100678703=:16382"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411160838.31853.wackysalut@bourget.cc>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alexandre B <wackysalut@bourget.cc>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2015913978-758783491-1100678703=:16382
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Alexandre B wrote:
> Le Mardi 16 Novembre 2004 03:10, vous avez écrit :
> > Alexandre B wrote:
> > > I'd like to use arecordmidi and aplaymidi to pipe MIDI events to a Perl
> > > script, which in turn would control light spots for a play.
> >
> > Well, this is not quite what these programs were designed for.
>
> aplaymidi already reads the .mid file.. it would just need to dump the events
> with the correct delays but not to the midi device, to the stdout.

Playing MIDI files (sending events at specified times) and converting
events to text are two completely different tasks, so there should be
two independent programs for each one.

Attached is tool that simply prints all MIDI events it receives.
(compile with "gcc -o dumpevents dumpevents.c -lasound")

> but how would I playback a saved .midi file ?

Run dumpevents (piping to your Perl script as desired), then tell
aplaymidi to play to its port.

If you want to play to two ports at the same time (e.g. dumpevents and
a synthesizer), load snd-seq-dummy and connect from a "through" port
to both destination ports.


HTH
Clemens

--2015913978-758783491-1100678703=:16382
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dumpevents.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.HPX.4.33n.0411170905030.16382@studcom.urz.uni-halle.de>
Content-Description: 
Content-Disposition: attachment; filename="dumpevents.c"

LyoNCiAqIGR1bXBldmVudHMuYyAtIHByaW50IEFMU0Egc2VxdWVuY2VyIGV2
ZW50cyBhcyB0ZXh0DQogKg0KICogLi4uIGJsYWggYmxhaCAuLi4gZnJlZXdh
cmUgLi4uIGJsYWggYmxhaCAuLi4gbm8gd2FycmFudHkgLi4uIGJsYWggYmxh
aCAuLi4NCiAqLw0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxz
dGRsaWIuaD4NCiNpbmNsdWRlIDxhbHNhL2Fzb3VuZGxpYi5oPg0KDQp2b2lk
IGNoZWNrKGludCBlcnIsIGNvbnN0IGNoYXIqIG9wZXJhdGlvbikNCnsNCglp
ZiAoZXJyIDwgMCkgew0KCQlmcHJpbnRmKHN0ZGVyciwgImNhbm5vdCAlczog
JXNcbiIsDQoJCQlvcGVyYXRpb24sIHNuZF9zdHJlcnJvcihlcnIpKTsNCgkJ
ZXhpdCgxKTsNCgl9DQp9DQoNCmludCBtYWluKCkNCnsNCglzbmRfc2VxX3Qg
KnNlcTsNCglpbnQgZXJyOw0KDQoJZXJyID0gc25kX3NlcV9vcGVuKCZzZXEs
ICJkZWZhdWx0IiwgU05EX1NFUV9PUEVOX0lOUFVULCAwKTsNCgljaGVjayhl
cnIsICJvcGVuIHNlcXVlbmNlciIpOw0KCWVyciA9IHNuZF9zZXFfc2V0X2Ns
aWVudF9uYW1lKHNlcSwgImR1bXBldmVudHMiKTsNCgljaGVjayhlcnIsICJz
ZXQgY2xpZW50IG5hbWUiKTsNCgllcnIgPSBzbmRfc2VxX2NyZWF0ZV9zaW1w
bGVfcG9ydChzZXEsICJkdW1wIHBvcnQiLCANCgkJCQkJIFNORF9TRVFfUE9S
VF9DQVBfV1JJVEUgfA0KCQkJCQkgU05EX1NFUV9QT1JUX0NBUF9TVUJTX1dS
SVRFLA0KCQkJCQkgU05EX1NFUV9QT1JUX1RZUEVfTUlESV9HRU5FUklDIHwN
CgkJCQkJIFNORF9TRVFfUE9SVF9UWVBFX0FQUExJQ0FUSU9OKTsNCgljaGVj
ayhlcnIsICJjcmVhdGUgcG9ydCIpOw0KDQoJZm9yICg7Oykgew0KCQlzdGF0
aWMgY29uc3Qgc3RydWN0IHsNCgkJCWludCB0eXBlOw0KCQkJY29uc3QgY2hh
ciAqbmFtZTsNCgkJfSBuYW1lc1tdID0gew0KCQkJe1NORF9TRVFfRVZFTlRf
Tk9URU9OLCAibm90ZV9vbiJ9LA0KCQkJe1NORF9TRVFfRVZFTlRfTk9URU9G
RiwgIm5vdGVfb2ZmIn0sDQoJCQl7U05EX1NFUV9FVkVOVF9LRVlQUkVTUywg
InBvbHlfYWZ0ZXJ0b3VjaCJ9LA0KCQkJe1NORF9TRVFfRVZFTlRfQ09OVFJP
TExFUiwgImNvbnRyb2xfY2hhbmdlIn0sDQoJCQl7U05EX1NFUV9FVkVOVF9Q
R01DSEFOR0UsICJwcm9ncmFtX2NoYW5nZSJ9LA0KCQkJe1NORF9TRVFfRVZF
TlRfQ0hBTlBSRVNTLCAiY2hhbm5lbF9hZnRlcnRvdWNoIn0sDQoJCQl7U05E
X1NFUV9FVkVOVF9QSVRDSEJFTkQsICJwaXRjaF9iZW5kIn0sDQoJCQl7U05E
X1NFUV9FVkVOVF9DT05UUk9MMTQsICJjb250cm9sX2NoYW5nZV8xNCJ9LA0K
CQkJe1NORF9TRVFfRVZFTlRfTk9OUkVHUEFSQU0sICJucnBuIn0sDQoJCQl7
U05EX1NFUV9FVkVOVF9SRUdQQVJBTSwgInJwbiJ9LA0KCQkJe1NORF9TRVFf
RVZFTlRfU1lTRVgsICJzeXNleCJ9LA0KCQl9Ow0KCQlzbmRfc2VxX2V2ZW50
X3QgKmV2Ow0KCQljb25zdCBjaGFyICpuYW1lID0gTlVMTDsNCgkJaW50IGk7
DQoNCgkJaWYgKHNuZF9zZXFfZXZlbnRfaW5wdXQoc2VxLCAmZXYpIDwgMCkN
CgkJCWNvbnRpbnVlOw0KCQlmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKG5hbWVz
KSAvIHNpemVvZihuYW1lc1swXSk7IGkrKykNCgkJCWlmIChuYW1lc1tpXS50
eXBlID09IGV2LT50eXBlKSB7DQoJCQkJbmFtZSA9IG5hbWVzW2ldLm5hbWU7
DQoJCQkJYnJlYWs7DQoJCQl9DQoJCWlmICghbmFtZSkNCgkJCWNvbnRpbnVl
Ow0KCQlzd2l0Y2ggKGV2LT50eXBlKSB7DQoJCWNhc2UgU05EX1NFUV9FVkVO
VF9OT1RFT046DQoJCWNhc2UgU05EX1NFUV9FVkVOVF9OT1RFT0ZGOg0KCQlj
YXNlIFNORF9TRVFfRVZFTlRfS0VZUFJFU1M6DQoJCQlwcmludGYoIiVzICVk
ICVkICVkXG4iLCBuYW1lLA0KCQkJICAgICAgIGV2LT5kYXRhLm5vdGUuY2hh
bm5lbCwgZXYtPmRhdGEubm90ZS5ub3RlLCBldi0+ZGF0YS5ub3RlLnZlbG9j
aXR5KTsNCgkJCWJyZWFrOw0KCQljYXNlIFNORF9TRVFfRVZFTlRfQ09OVFJP
TExFUjoNCgkJY2FzZSBTTkRfU0VRX0VWRU5UX0NPTlRST0wxNDoJLyogbW9z
dCBjbGllbnRzIHNpbXBseSAuLi4gKi8NCgkJY2FzZSBTTkRfU0VRX0VWRU5U
X05PTlJFR1BBUkFNOgkvKiAuLi4gc2VuZCBtdWx0aXBsZSBjb250cm9sbGVy
Li4uICovDQoJCWNhc2UgU05EX1NFUV9FVkVOVF9SRUdQQVJBTToJLyogLi4u
IGV2ZW50cyBpbnN0ZWFkIG9mIHRoZXNlIHRocmVlICovDQoJCQlwcmludGYo
IiVzICVkICVkICVkXG4iLCBuYW1lLA0KCQkJICAgICAgIGV2LT5kYXRhLmNv
bnRyb2wuY2hhbm5lbCwgZXYtPmRhdGEuY29udHJvbC5wYXJhbSwgZXYtPmRh
dGEuY29udHJvbC52YWx1ZSk7DQoJCQlicmVhazsNCgkJY2FzZSBTTkRfU0VR
X0VWRU5UX1BHTUNIQU5HRToNCgkJY2FzZSBTTkRfU0VRX0VWRU5UX0NIQU5Q
UkVTUzoNCgkJY2FzZSBTTkRfU0VRX0VWRU5UX1BJVENIQkVORDoNCgkJCXBy
aW50ZigiJXMgJWQgJWRcbiIsIG5hbWUsDQoJCQkgICAgICAgZXYtPmRhdGEu
Y29udHJvbC5jaGFubmVsLCBldi0+ZGF0YS5jb250cm9sLnZhbHVlKTsNCgkJ
CWJyZWFrOw0KCQljYXNlIFNORF9TRVFfRVZFTlRfU1lTRVg6DQoJCQlwcmlu
dGYoIiVzIiwgbmFtZSk7DQoJCQlmb3IgKGkgPSAwOyBpIDwgZXYtPmRhdGEu
ZXh0LmxlbjsgaSsrKQ0KCQkJCXByaW50ZigiICUwMngiLCBpWyh1bnNpZ25l
ZCBjaGFyKilldi0+ZGF0YS5leHQucHRyXSk7DQoJCQlwcmludGYoIlxuIik7
DQoJCQlicmVhazsNCgkJfQ0KCX0NCn0NCg==
--2015913978-758783491-1100678703=:16382--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
