From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: [PATCH] Tascam US-224/428 MMC: Jog wheel stepping (locate not)
Date: Wed, 28 Jul 2004 23:12:06 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32979.192.168.1.5.1091052726.squirrel@192.168.1.5>
References: Your message of "Wed, 28 Jul 2004 17:24:37 BST."               
    <63176.195.245.190.93.1091031877.squirrel@195.245.190.93>   
    <200407281653.i6SGrMZn032601@localhost.localdomain>
    <32930.192.168.1.5.1091045020.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040728231206_60103"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32930.192.168.1.5.1091045020.squirrel@192.168.1.5>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Paul Davis <paul@linuxaudiosystems.com>, Karsten Wiese <annabellesgarden@yahoo.de>, ardour-dev <ardour-dev@lists.ardour.org>
List-Id: alsa-devel@alsa-project.org

------=_20040728231206_60103
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>>
>>>I guess that's most likely due to something as a race condition between
>>>ardour and us428control: by turning the jog wheel a MMC-Locate command
>>
>> I have no experience of wheels that send Locate. The wheel on the d8b
>> sends either Shuttle or Step commands. I have no idea how a wheel that
>> sends Locate is supposed to work, for precisely the reason you mention.
>>
>
> Shame on me. As a matter of fact, I've have no experience either, at all
> :) It seems that my MMC jog wheel implementation is most probably a
> complete mistake. I'm an idiot, spank me ;)
>
> I'll try the MMC-Step/Shuttle route instead of that miserable MMC-Locate
> wheel hack.
>
> Stay tuned...

OK. I've just rewritten that gross conceptual mistake of mine, and now the
US-224/428 jog wheel is now spitting out some MMC-Step(s) instead of that
whole MMC-Locate trouble.

Not sure if my metrics are welcome, regarding that one wheel tick is
translated into 2 (MMC-)steps. Someone with better experience might speak
now ;)

The patch attached is, as before, against the latest alsa-tools cvs tree
(assumed that previous one, us428control-0.4.2 has been already applied,
now bumped to us428control-0.4.3).

Cheers,
--
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20040728231206_60103
Content-Type: application/x-gzip; name="us428control-0.4.3.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="us428control-0.4.3.patch.gz"

H4sICBQhCEEAA3VzNDI4Y29udHJvbC0wLjQuMy5wYXRjaACtV21vm0gQ/mz/ilErpVAMWcBvsXtV
LMdqo7ObKHbrnnKRRWBdUA1EsM5Vvet/v9ldsCHGriOFSCa7OzO7M88zO4MXLJege+vrTwk4q9TR
WRyvUoOcrtOm1XXjiCXx6hTfy+DbOqFGEBXFzP1idV3Xj7RYswhp6qSjW10w271Wu9dsGSR/QCMm
IXVN047cuWjOsnqtVs9uGWedjtVudbu5ufNz0M1GCzT+c35eh8FwcfnpcqYUzRquq9b1wUSsLAaf
Z1eTwZ+jkkgDiNE0LLWuHSFmq2Kf65urD4vh16/bweWn6WwwHouJj6PBxehmMZ1dDOveUegMxWgS
eAEe+ECQSnK/wack+wIA7bVXQKiLCHVwqoCQ3W50ECPx4ijV+HOfUOd7Xw5cJ6UwmQwXw8nFYnw1
HMxGvUwsWILySJP7GCXeg4lIiuna8iEJIrZUUubRJGnAK6kG84+j0dj4O3ql9uvaQdFMSG5zFdEp
cxjV349jF99zn9KVcuI5zLnt3G3E9h6av29G09Gs9yy4xZ7H4J0LHgV4LvxiiFcZLEB+hpC3Ou0C
5BZi3bJB42+7K0EX8ZKBFeBeO4kTwh9AfrSJCOnpKXx+wIhTYD4F5z6NV2sc/MM14CFOAxbEkcEJ
IIxc0BVzFAWhVUFR1lEafIuoB67vJG9VEOdeuGyVqrdzDiCqSWinNPIUyQ5hZ8roQ7UZqLIDBRb8
QqsiG7hN/s9Qhk0RvjV2j7VjTXuOfvV5ftWB/2H0UBtThQELQqq7sUdB8f1eGPbStLdc9paJCuhm
vD+08BgHHhQw7/UK6QAKPDkOcwEvw3/r+mtMU4IBcaQgoqq0CbwF8WMTFX9lhJl7S+4E1L4POvjx
OkkBn1tiGJZ9JzJLw434U6VsSuUwROUwiNCJVCq3zsrK4nmibEnlNEXllCLFvR3lnWejbN/1hTZP
blgiPHxneW7U1l/TVUqRDtUROD4A+k4Ajvdf3/H/ePf1SvcL3sMpmKR/MAIRXn1VfNzDN0nG/WSt
67t0FNGdoYrUqCSkto/Fv9FDIkMNzwRzRE/i2M+preGSgA6X5hiKMr37OKcf5nxfGjA3BkoUzw0c
4H1mwCobyGleMlDN/cyALQxkgyYfkP6Wvvt8rHJxx0N9r4dVDu74p+/1r8q9He/0rXe4ZJJspuDi
U35+oEyUGklLXrdpQiMWOCtjL/dE1cGDSJ5Ukm1TVQpiglsiJcKHdVbhqraVBPTmwgsd5nhwUU/P
ug2sr1bXbphNWU65MSd6w+CewopiUjPfieAnTWJhBdum7Cp6B0Tlt1s2FMHQsPCUUyDF8/JyxBVx
e6GEFZJP87usJMwLpaKj1AkWb3upwrt32JnBfzhqElHUBJsOqfMthFJmQh5pWwtDFyMVOlip8w5r
OhtdN+CEW2xAGvykMe/o6IO6rYE8Ujbp8GbTJiRvNst+ouUL3tS1RT5gEPNL4U0KNLynnoeSeDfh
tuDKI/B45moiOcgPYnJ2lS4j5SSXMWVhL985T5bF1txTwQS+2UqIb/Y0xK4H4iGb2Ebu0CYm2TgL
y/ObUf/IbtB/Rivqv3An6lc3ol2CjWjTaha/PUi7YWIjmr05IQA/Bx55omKARfLyAH/BAhVS/Nr7
av21eBQDOPkigEpZsnaZbLx437VIkUfUC2n4tmqSE+MeHcA7Shz2MsKEn8RRwOJEUfEe0ORy9SLm
aULZOokAxsE3n12mCh0vimKqbDwzAh24wKRzhVZZ3EWCmtsV0fzmC8Jmfim6a24qM80yFpfNbri9
U023uzzJgipJ4ElaCPyC1SQcty2RpFy0Vpusy+Fq1P8HIIPXdvYQAAA=
------=_20040728231206_60103--




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
